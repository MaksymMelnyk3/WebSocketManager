//
//  File.swift
//  
//
//  Created by Maxim on 13.09.2022.
//



import Foundation

public class GlobalSettings {
    var food: [FoodData] = []
    var cell: [Cell] = []
    var tick: Int = 0
    var lastTick: Int = 0
    
    let lock = NSLock()
    
    func ticksOperation(gameData: GameDataModel) {
        let queue = DispatchQueue(label: "threadSafety1", attributes: [.concurrent])
//        queue.async {
//            self.lock.lock()
            if let tick = gameData.data?.tick {
                self.tick = tick
            }
            
            if let lastTick = gameData.data?.lastReceivedTick {
                self.lastTick = lastTick
            }
//            self.lock.unlock()
//        }
    }
    
    func cellsOperation(gameData: GameDataModel) {
        let queue = DispatchQueue(label: "threadSafety2", attributes: [.concurrent])
        var cells = self.cell
//        queue.async {
//            self.lock.lock()
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
//            self.lock.unlock()
//        }
        
        self.cell = cells
    }
    
    func foodsOperation(gameData: GameDataModel) {
        
        let queue = DispatchQueue(label: "threadSafety3", attributes: [.concurrent])
        var foods = self.food
//        queue.async {
//            self.lock.lock()
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
                        foods.append(food) }
                }
            }
//            self.lock.unlock()
//        }
        
        self.food = foods
    }
    
}
