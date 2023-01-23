//
//  File.swift
//  
//
//  Created by Maxim on 26.09.2022.
//

import Foundation


public struct MapState {
    let tick: Int
    let lastResivedTick: Int
    let food: [Food]
    let cell: [Cell]
    
    init(food: [Food], cell: [Cell], tick: Int, lastResivedTick: Int) {
        self.food = food
        self.cell = cell
        self.tick = tick
        self.lastResivedTick = lastResivedTick
    }
}

public struct Food {
    var id: String
    var isNew: Bool
    var position: Coordinates
    var del: Bool
}

public struct Cell {
    var id: String
    var isNew: Bool
    var player: String
    var mass: Double
    var canSplit: Bool
    var radius: Double
    var velocity: Coordinates
    var speed: Double
    var direction: Coordinates
    var availableEnergy, eatEfficiency: Double
    var maxSpeed: Double
    var power, volatilization: Double
    var mergeTimer: Int
    var canMerge: Bool
    var position: Coordinates
    var own: Bool
    var del: Bool
}

public struct Coordinates {
    let x: Double
    let y: Double
}


