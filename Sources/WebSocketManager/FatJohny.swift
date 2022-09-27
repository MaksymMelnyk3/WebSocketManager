//
//  File.swift
//  
//
//  Created by Maxim on 04.08.2022.
//

import Foundation


public class FatJohny: CellLogic {
    
    public init(){}
    
    public var gameConfig: GameConfigModel?
    
    public func configure(gameConfig: GameConfigModel) {
        self.gameConfig = gameConfig
    }
    
    public func handleGameUpdate(mapState: UserData) -> [CellActivity]? {
        return mapState.cell.map({ myCell in
            let from = myCell.velocity
            let target = findClosestFood(mapState: mapState, myCell: myCell)?.position
            
            let velocity = from?.moveToPosition(target: target ?? Position(x: 0, y: 0))
            
            let cellActivity = CellActivity(cellId: (myCell.id)!, speed: 1.0, velocity: velocity, growIntention: GrowIntention(mass: myCell.availableEnergy))
            return cellActivity
        })
    }
    
    func findClosestFood(mapState: UserData, myCell: Cell) -> FoodData? {
        let distanceWithFood = mapState.food.map({ food -> (Double?, FoodData?) in
            let distance = food.position?.distanceToPosition(target: myCell.position ?? Position(x: 1, y: 1))
            return (distance, food)
        })
        
        var closestFood: (Double?, FoodData?)? = nil
        distanceWithFood.map {
            if closestFood == nil{
                closestFood = $0
            } else {
                if $0.0! < Double((closestFood?.0)!) {
                    closestFood = $0
                }
            }
        }
        
        return (closestFood?.1!)
        
    }
    
    
}
