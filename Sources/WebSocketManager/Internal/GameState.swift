//
//  File.swift
//  
//
//  Created by Maxim on 13.09.2022.
//



import Foundation

class GameState {
    private(set) var playerId: String!
    private(set) var food: [Food] = []
    private(set) var cell: [Cell] = []
    var tick: Int = 0
    var lastTick: Int = 0
    
    public func setPlayer(_ playerId: String) {
        self.playerId = playerId
    }
    
    public func updateFood(_ food: [Food]) {
        self.food = food
    }
    
    public func updateCells(_ cells: [Cell]) {
        self.cell = cells
    }
}
