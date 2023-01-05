//
//  File.swift
//  
//
//  Created by Maxim on 12.07.2022.
//

import Foundation


public protocol CellLogic {
    
    var gameConfig: GameConfig? { get set }
    
    func configure(gameConfig: GameConfig)
    
    func handleGameUpdate(mapState: MapState) -> [CellActivity]

}
