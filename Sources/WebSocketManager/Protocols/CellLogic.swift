//
//  File.swift
//  
//
//  Created by Maxim on 12.07.2022.
//

import Foundation


public protocol CellLogic{
    
    var gameConfig: GameConfigModel? { get set }
    
    func configure(gameConfig: GameConfigModel)
    
    func handleGameUpdate(mapState: GameDataModel) -> DesiredCellsState?

}
