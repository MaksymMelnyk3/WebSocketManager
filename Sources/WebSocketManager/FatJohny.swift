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
    
    public func handleGameUpdate(mapState: GameDataModel) -> [CellActivity]? {
        return mapState.data?.cells.map({ myCell in
            let from = myCell.first?.velocity
            let target = findClosestFood(mapState: mapState, myCell: myCell.first!)?.position
            
            let velocity = from?.moveToPosition(target: target ?? Position(x: 0, y: 0))
            
            let cellActivity = CellActivity(cellId: (myCell.first?.id)!, speed: 1.0, velocity: velocity, growIntention: GrowIntention(mass: myCell.first?.availableEnergy))
            
            return [cellActivity]
        })
    }
    
    func findClosestFood(mapState: GameDataModel, myCell: Cell) -> FoodData? {
        let distanceWithFood = mapState.data?.food.map({ food -> (Double?, FoodData?) in
            let distance = food.first?.position?.distanceToPosition(target: myCell.position!)
            return (distance, food.first)
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
