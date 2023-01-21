//
//  File.swift
//  
//
//  Created by Maxim on 26.09.2022.
//

import Foundation


public struct MapState {
    public let tick: Int
    public let lastResivedTick: Int
    public let food: [Food]
    public let cell: [Cell]
    
    init(food: [Food], cell: [Cell], tick: Int, lastResivedTick: Int) {
        self.food = food
        self.cell = cell
        self.tick = tick
        self.lastResivedTick = lastResivedTick
    }
}

public struct Food {
    public var id: String
    public var isNew: Bool
    public var position: Coordinates
    public var del: Bool
}

public struct Cell {
    public var id: String
    public var isNew: Bool
    public var player: String
    public var mass: Double
    public var canSplit: Bool
    public var radius: Double
    public var velocity: Coordinates
    public var speed: Double
    public var direction: Coordinates
    public var availableEnergy, eatEfficiency: Double
    public var maxSpeed: Double
    public var power, volatilization: Double
    public var mergeTimer: Int
    public var canMerge: Bool
    public var position: Coordinates
    public var own: Bool
    public var del: Bool
}

public struct Coordinates {
    public let x: Double
    public let y: Double
}


