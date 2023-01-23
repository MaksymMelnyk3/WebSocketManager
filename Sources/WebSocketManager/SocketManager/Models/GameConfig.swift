//
//  GameConfig.swift
//  
//
//  Created by Anastasiia Spiridonova on 03.01.2023.
//

import Foundation

public struct GameConfig {
    public let tickTime, ticksLimit: Int
    public let map: MapConfig
    public let cell: CellConfig
    public let food: FoodConfig
}

public struct CellConfig {
    // radius = Sqrt(mass / PI) * massToRadius
    public let massToRadius: Double
    // mass difference needed to eat another cell
    public let toEatDiff: Double
    // cells must cross on this value to eat:
    // (cell_1.radius * collisionOffset + cell_2.radius * collisionOffset) < distance
    public let collisionOffset: Double
    public let minEatEfficiency: Double
    public let maxEatEfficiency: Double
    public let energyToEatEfficiency: Double // energy exchange rate for eat efficiency
    public let minMass: Double
    public let maxMass: Double
    public let energyToMass: Double
    public let minSpeed: Double
    public let maxSpeed: Double
    public let energyToMaxSpeed: Double
    // acceleration
    public let minPower: Double
    public let maxPower: Double
    public let energyToPower: Double
    public let maxVolatilization: Double
    public let minVolatilization: Double
    public let energyToVolatilization: Double
}

public struct MapConfig {
    public let width, height: Int
}

public struct FoodConfig {
    public let mass: Double
}
