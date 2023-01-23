//
//  File.swift
//  
//
//  Created by Maxim on 04.08.2022.
//

import Foundation


public class FatJohny: CellLogic {
    
    public init(){}
    
    public var gameConfig: GameConfig?
    
    public func configure(gameConfig: GameConfig) {
        self.gameConfig = gameConfig
    }
    
    public func handleGameUpdate(mapState: MapState) -> [CellActivity] {
        
        return mapState.cell.map({ myCell in
            guard let target = myCell.findClosestFood(from: mapState.food)?.position
            else {
                return CellActivity(cellId: myCell.id)
            }
            let velocity = myCell.position.moveTo(target: target)
            let cellActivity = CellActivity(cellId: myCell.id, speed: 5.0, velocity: velocity, growIntention: GrowIntention(mass: myCell.availableEnergy))
            return cellActivity
        })
    }
}

private extension Coordinates {
    func moveTo(target: Coordinates) -> Coordinates {
        return Coordinates(x: target.x - x, y: target.y - y)
    }
    
    func distanceToPosition(target: Coordinates) -> Double {
        return sqrt(((target.y - y) * (target.y - y) + (target.x - x) * (target.x - x)))
    }
}

private extension Cell {
    func findClosestFood(from foodArray: [Food]) -> Food? {
        foodArray
            .sorted {
                $0.position.distanceToPosition(target: position) < $1.position.distanceToPosition(target: position)
                
            }
            .first
    }
}

