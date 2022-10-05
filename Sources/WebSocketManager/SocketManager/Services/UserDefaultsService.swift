//
//  File.swift
//  
//
//  Created by Maxim on 13.09.2022.
//



import Foundation

@propertyWrapper
    struct UserDefault<T: Codable> {
        let key: String
        let defaultValue: T

        init(_ key: String, defaultValue: T) {
            self.key = key
            self.defaultValue = defaultValue
        }

        var wrappedValue: T {
            get {

                if let data = UserDefaults.standard.object(forKey: key) as? Data,
                    let user = try? JSONDecoder().decode(T.self, from: data) {
                    return user

                }

                return defaultValue
            }
            set {
                if let encoded = try? JSONEncoder().encode(newValue) {
                    UserDefaults.standard.set(encoded, forKey: key)
                }
            }
        }
    }

public class GlobalSettings {
    @UserDefault("food", defaultValue: []) var food: [FoodData]
    @UserDefault("cell", defaultValue: []) var cell: [Cell]
    @UserDefault("tick", defaultValue: 0) var tick: Int
    @UserDefault("lastTick", defaultValue: 0) var lastTick: Int
    
    func clearData() {
        UserDefaults.standard.removeObject(forKey: "food")
        UserDefaults.standard.removeObject(forKey: "cell")
        UserDefaults.standard.removeObject(forKey: "tick")
        UserDefaults.standard.removeObject(forKey: "lastTick")
    }
    
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

                    cellToUpdate.update(cell: cell)

                    cells[index] = cellToUpdate
                }
            }
        }
        
        if let newCells = gameData.data?.cells?.filter({ $0.isNew ?? false }) {
            newCells.forEach { cell in
                if !cells.contains(where: { $0.id == cell.id }) {
                    cells.append(cell)
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

                    foodToUpdate.update(food: food)

                    foods[index] = foodToUpdate
                }
            }
        }
        
        if let newFoods = gameData.data?.food?.filter({ $0.isNew ?? false }) {
            newFoods.forEach { food in
                if !foods.contains(where: { $0.id == food.id }) {
                    foods.append(food)
                }
            }
        }
        
        self.food = foods
    }
    
}
