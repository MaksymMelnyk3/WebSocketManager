import Foundation
import Starscream

public protocol WebSocketManagerDelegate: AnyObject {
    func webSocketManager(didConnect player: String)
    
    func webSocketManager(didReceive gameConfig: GameConfig)
    
    func webSocketManager(didReceive newCells: [Cell])
    func webSocketManager(didRemove cells: [Cell])
    func webSocketManager(didUpdate cells: [Cell])
    
    func webSocketManager(didReceive newFood: [Food])
    func webSocketManager(didRemove food: [Food])
}


public class WebSocketManager {
    public weak var delegate: WebSocketManagerDelegate?
    
    private let socket = WebSocket(request: URLRequest(url: URL(string: "http://45.77.67.171/")!))
    
    private var gameState = GameState()

    private let cellLogic: CellLogic
    

    public init(cellLogic: CellLogic) {
        self.cellLogic = cellLogic
        del()
    }

    deinit {
      socket.disconnect(forceTimeout: 0)
      socket.delegate = nil
    }
    
    public func connect(roomName: String, watch: Bool = false) {
        socket.connect()
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
        let connectModel = ConnectModel(data: ConnectDataModel(roomName: roomName, watch: watch))
            do {
                let encoder = JSONEncoder()
                encoder.keyEncodingStrategy = .convertToSnakeCase
                let connectData = try encoder.encode(connectModel)
                if self.socket.isConnected {
                    self.socket.write(data: connectData)
                } else {
                    self.socket.connect()
                }
            } catch {
                print("Error: cannot create JSON")
                return
            }
        }
   }
    
    private func del() {
        socket.onConnect = {
            print("coonect")
        }
        
        socket.onText = { [weak self] text in
            guard let data = text.data(using: .utf8),
                  let gameData: KeyModel = self?.decode(data: data)
            else { return }
            switch gameData.key {
            case Keys.connected.rawValue:
                let connectData: ConnectedModel? = self?.decode(data: data)
                guard let playerId = connectData?.data?.playerID else { return }
                self?.gameState.setPlayer(playerId)
                self?.delegate?.webSocketManager(didConnect: playerId)
            case Keys.config.rawValue:
                guard let configData: GameConfigDTO = self?.decode(data: data) else { return }
                let gameConfig = GameConfig(with: configData.data)
                self?.cellLogic.configure(gameConfig: gameConfig)
                self?.delegate?.webSocketManager(didReceive: gameConfig)
            case Keys.data.rawValue:
                guard let gameData: GameDataModel = self?.decode(data: data) else { return }
                self?.dataReceived(tick: gameData.data?.tick ?? 0)
                
                self?.ticksOperation(gameData: gameData)
                self?.cellsOperation(gameData: gameData)
                self?.foodsOperation(gameData: gameData)
                
                self?.playerAction()
                
            default:
                print("raw")
            }
        }
    }
    
    private func decode<T: Decodable>(data: Data) -> T? {
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            print(error)
            return nil
        }
    }
    
    private func playerAction() {
        print(gameState.tick)
        let result = self.cellLogic.handleGameUpdate(mapState: MapState(food: gameState.food, cell: gameState.cell, tick: gameState.tick, lastResivedTick: gameState.lastTick))
            if result.isEmpty {
                print("empty")
            } else {
                let playerData = PlayerData(
                    cells: result.map( { CellActivityDTO(
                        cellId: $0.id,
                        speed: $0.speed,
                        velocity: .init(
                            x: $0.velocity?.x,
                            y: $0.velocity?.y
                        ),
                        growIntention: .init(
                            eatEfficiency: $0.growIntention?.eatEfficiency,
                            maxSpeed: $0.growIntention?.maxSpeed,
                            power: $0.growIntention?.power,
                            mass: $0.growIntention?.mass,
                            volatilization: $0.growIntention?.volatilization),
                        additionalAction: .init(
                            split: $0.additionalAction?.split,
                            merge: $0.additionalAction?.merge
                            )
                        )}))
                let myData = PlayerAction(key: "player_action", data: playerData)

                do {
                    let jsonData = try JSONEncoder().encode(myData)
                    self.socket.write(data: jsonData)
                } catch {
                    print("Error: cannot create JSON")
                    return
                }
            }
        }
    
    
    private func dataReceived(tick: Int) {
        let myData: [String: Any] = ["key": "data_received", "data": ["tick": tick]]

        let myJSON: Data

        do {
            myJSON = try JSONSerialization.data(withJSONObject: myData, options: [])
            self.socket.write(data: myJSON)
        } catch {
            print("Error: cannot create JSON")
            return
        }
    }
}

private extension WebSocketManager {
    
    func ticksOperation(gameData: GameDataModel) {
        if let tick = gameData.data?.tick {
            self.gameState.tick = tick
        }
        
        if let lastTick = gameData.data?.lastReceivedTick {
            self.gameState.lastTick = lastTick
        }
    }
    
    func cellsOperation(gameData: GameDataModel) {
        var cells = self.gameState.cell
        if let deeltedCells = gameData.data?.cells?.filter({ $0.del ?? false }) {
            deeltedCells.forEach { cell in
                cells.removeAll(where: { $0.id == cell.id })
            }
            delegate?.webSocketManager(didRemove: deeltedCells.map({ Cell($0, playerId: gameState.playerId) }))
        }
        
        if let updatedCells = gameData.data?.cells?.filter({ cell in
            (cell.isNew == false || cell.isNew == nil) &&
            (cell.del == false ||  cell.del == nil)
        }) {
            updatedCells.forEach { cell in
                if let index = cells.firstIndex(where: { cell.id == $0.id } ) {
                    var cellToUpdate = cells[index]
                    cellToUpdate.update(with: cell)
                    cells[index] = cellToUpdate
                }
            }
            delegate?.webSocketManager(didUpdate: cells)
        }
        
        if let newCells = gameData.data?.cells?.filter({ $0.isNew ?? false }) {
            newCells.forEach { cell in
                if !cells.contains(where: { $0.id == cell.id }) {
                    cells.append(Cell(cell, playerId: gameState.playerId))
                }
            }
            delegate?.webSocketManager(didReceive: newCells.map({ Cell($0, playerId: gameState.playerId) }))
        }
        self.gameState.updateCells(cells)
    }
    
    func foodsOperation(gameData: GameDataModel) {
        var foods = self.gameState.food
        if let deeltedFoods = gameData.data?.food?.filter({ $0.del ?? false }) {
            deeltedFoods.forEach { food in
                foods.removeAll(where: { $0.id == food.id })
            }
            delegate?.webSocketManager(didRemove: deeltedFoods.map(Food.init))
        }
        
        if let updatedFoods = gameData.data?.food?.filter({ food in
            (food.isNew == false || food.isNew == nil) &&
            (food.del == false ||  food.del == nil)
        }) {
            updatedFoods.forEach { food in
                if let index = foods.firstIndex(where: { food.id == $0.id } ) {
                    var foodToUpdate = foods[index]
                    
                    foodToUpdate.update(with: food)
                    
                    foods[index] = foodToUpdate
                }
            }
        }
        
        if let newFoods = gameData.data?.food?.filter({ $0.isNew ?? false }) {
            newFoods.forEach { food in
                if !foods.contains(where: { $0.id == food.id }) {
                    foods.append(Food(food)) }
            }
            delegate?.webSocketManager(didReceive: newFoods.map(Food.init))
        }
        
        self.gameState.updateFood(foods)
    }
    
}

private extension Cell {
    init(_ cell: CellDTO, playerId: String) {
        id = cell.id
        isNew = cell.isNew ?? false
        player = cell.player ?? ""
        mass = cell.mass ?? 0.0
        canSplit = cell.canSplit ?? false
        radius = cell.radius ?? 0.0
        if let velocityDTO = cell.velocity {
            velocity = Coordinates(x: velocityDTO.x, y: velocityDTO.y)
        } else {
            velocity = Coordinates(x: 0.0, y: 0.0)
        }
        speed = cell.speed ?? 0.0
        if let directionDTO = cell.direction {
            direction = Coordinates(x: directionDTO.x, y: directionDTO.y)
        } else {
            direction = Coordinates(x: 0.0, y: 0.0)
        }
        availableEnergy = cell.availableEnergy ?? 0.0
        eatEfficiency = cell.eatEfficiency ?? 0.0
        maxSpeed = cell.maxSpeed ?? 0.0
        power = cell.power ?? 0.0
        volatilization = cell.volatilization ?? 0.0
        mergeTimer = cell.mergeTimer ?? 0
        canMerge = cell.canMerge ?? false
        if let positionDTO = cell.position {
            position = Coordinates(x: positionDTO.x, y: positionDTO.y)
        } else {
            position = Coordinates(x: 0.0, y: 0.0)
        }
        if let own = cell.own {
            self.own = own
        } else {
            own = cell.player == playerId
        }
        del = cell.del ?? false
    }
    
    mutating func update(with cell: CellDTO) {
        guard cell.id == id else {
            return
        }
        if let canMerge = cell.canMerge {
            self.canMerge = canMerge
        }
        if let player = cell.player {
            self.player = player
        }
        if let mass = cell.mass {
            self.mass = mass
        }
        if let canSplit = cell.canSplit {
            self.canSplit = canSplit
        }
        if let radius = cell.radius {
            self.radius = radius
        }
        if let velocity = cell.velocity {
            self.velocity = Coordinates(x: velocity.x, y: velocity.y)
        }
        if let speed = cell.speed {
            self.speed = speed
        }
        if let direction = cell.direction {
            self.direction = Coordinates(x: direction.x, y: direction.y)
        }
        if let availableEnergy = cell.availableEnergy {
            self.availableEnergy = availableEnergy
        }
        if let eatEfficiency = cell.eatEfficiency {
            self.eatEfficiency = eatEfficiency
        }
        if let maxSpeed = cell.maxSpeed {
            self.maxSpeed = maxSpeed
        }
        if let power = cell.power {
            self.power = power
        }
        if let volatilization = cell.volatilization {
            self.volatilization = volatilization
        }
        if let mergeTimer = cell.mergeTimer {
            self.mergeTimer = mergeTimer
        }
        if let position = cell.position {
            self.position = Coordinates(x: position.x, y: position.y)
        }
        if let own = cell.own {
            self.own = own
        }
        if let del = cell.del {
            self.del = del
        }
    }
}

private extension Food {
    init(_ foodData: FoodDataDTO) {
        id = foodData.id
        isNew = foodData.isNew ?? false
        position = Coordinates(x: foodData.position?.x ?? 0.0, y: foodData.position?.y ?? 0.0)
        del = foodData.del ?? false
    }
    
    mutating func update(with foodData: FoodDataDTO) {
        guard id == foodData.id else { return }
        if let isNew = foodData.isNew {
            self.isNew = isNew
        }
        if let position = foodData.position {
            self.position = Coordinates(x: position.x, y: position.y)
        }
        if let del = foodData.del {
            self.del = del
        }
    }
}


private extension GameConfig {
    init(with dataConfigDTO: DataConfigDTO) {
        tickTime = dataConfigDTO.tickTime
        ticksLimit = dataConfigDTO.ticksLimit
        map = MapConfig(
            width: dataConfigDTO.map.width,
            height: dataConfigDTO.map.height
        )
        
        let cellConfig = dataConfigDTO.cell
        cell = CellConfig(
            massToRadius: cellConfig.massToRadius,
            toEatDiff: cellConfig.toEatDiff,
            collisionOffset: cellConfig.collisionOffset,
            minEatEfficiency: cellConfig.minEatEfficiency,
            maxEatEfficiency: cellConfig.maxEatEfficiency,
            energyToEatEfficiency: cellConfig.energyToEatEfficiency,
            minMass: cellConfig.minMass,
            maxMass: cellConfig.maxMass,
            energyToMass: cellConfig.energyToMass,
            minSpeed: cellConfig.minSpeed,
            maxSpeed: cellConfig.maxSpeed,
            energyToMaxSpeed: cellConfig.energyToMaxSpeed,
            minPower: cellConfig.minPower,
            maxPower: cellConfig.maxPower,
            energyToPower: cellConfig.energyToPower,
            maxVolatilization: cellConfig.maxVolatilization,
            minVolatilization: cellConfig.minVolatilization,
            energyToVolatilization: cellConfig.energyToVolatilization
        )
        
        food = FoodConfig(mass: dataConfigDTO.food.mass)
    }
}

