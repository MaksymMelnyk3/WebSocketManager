import Foundation
import Starscream

@available(iOS 13.0, *)
public class WebSocketManager {
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
    
    public func connect(roomName: String, watch: Bool) {
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
                self?.gameState.playerId = connectData?.data?.playerID
            case Keys.config.rawValue:
                guard let configData: GameConfigDTO = self?.decode(data: data) else { return }
                self?.cellLogic.configure(gameConfig: GameConfig(with: configData.data))
            case Keys.data.rawValue:
                guard let gameData: GameDataModel = self?.decode(data: data) else { return }
                self?.dataReceived(tick: gameData.data?.tick ?? 0)
                
                self?.gameState.ticksOperation(gameData: gameData)
                self?.gameState.cellsOperation(gameData: gameData)
                self?.gameState.foodsOperation(gameData: gameData)
                
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
