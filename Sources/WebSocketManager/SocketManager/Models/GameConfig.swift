//
//  GameConfig.swift
//  
//
//  Created by Anastasiia Spiridonova on 03.01.2023.
//

import Foundation

public struct GameConfig {
    let tickTime, ticksLimit: Int
    let map: MapConfig
    let cell: CellConfig
    let food: FoodConfig
}

public struct CellConfig {
    // radius = Sqrt(mass / PI) * massToRadius
    let massToRadius: Double
    // mass difference needed to eat another cell
    let toEatDiff: Double
    // cells must cross on this value to eat:
    // (cell_1.radius * collisionOffset + cell_2.radius * collisionOffset) < distance
    let collisionOffset: Double
    let minEatEfficiency: Double
    let maxEatEfficiency: Double
    let energyToEatEfficiency: Double // energy exchange rate for eat efficiency
    let minMass: Double
    let maxMass: Double
    let energyToMass: Double
    let minSpeed: Double
    let maxSpeed: Double
    let energyToMaxSpeed: Double
    // acceleration
    let minPower: Double
    let maxPower: Double
    let energyToPower: Double
    let maxVolatilization: Double
    let minVolatilization: Double
    let energyToVolatilization: Double
}

struct MapConfig {
    let width, height: Int
}

struct FoodConfig {
    let mass: Double
}
