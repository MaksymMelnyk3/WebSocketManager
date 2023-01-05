//
//  File.swift
//  
//
//  Created by Maxim on 13.09.2022.
//



import Foundation

class GameState {
    public var playerId: String!
    public var food: [Food] = []
    public var cell: [Cell] = []
    public var tick: Int = 0
    public var lastTick: Int = 0
    
    func ticksOperation(gameData: GameDataModel) {
        if let tick = gameData.data?.tick {
            self.tick = tick
        }
        
        if let lastTick = gameData.data?.lastReceivedTick {
            self.lastTick = lastTick
        }
    }
    
    func cellsOperation(gameData: GameDataModel) {
        var cells = self.cell
        if let deeltedCells = gameData.data?.cells?.filter({ $0.del ?? false }) {
            deeltedCells.forEach { cell in
                cells.removeAll(where: { $0.id == cell.id })
            }
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
        }
        
        if let newCells = gameData.data?.cells?.filter({ $0.isNew ?? false }) {
            newCells.forEach { cell in
                if !cells.contains(where: { $0.id == cell.id }) {
                    cells.append(Cell(cell, playerId: playerId))
                }
            }
        }
        self.cell = cells
    }
    
    func foodsOperation(gameData: GameDataModel) {
        var foods = self.food
        if let deeltedFoods = gameData.data?.food?.filter({ $0.del ?? false }) {
            deeltedFoods.forEach { food in
                foods.removeAll(where: { $0.id == food.id })
            }
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
        }
        
        self.food = foods
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
