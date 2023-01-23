//
//  File.swift
//  
//
//  Created by Maxim on 03.07.2022.
//

import Foundation

struct GameConfigDTO: Decodable {
    let key: String
    let data: DataConfigDTO
}

struct DataConfigDTO: Decodable {
    let tickTime, ticksLimit: Int
    let map: MapDTO
    let cell: CellConfigDTO
    let food: FoodConfigDTO
}

struct CellConfigDTO: Decodable {
    let massToRadius: Double
    let toEatDiff: Double
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
    let minPower: Double
    let maxPower: Double
    let energyToPower: Double
    let maxVolatilization: Double
    let minVolatilization: Double
    let energyToVolatilization: Double
}

struct MapDTO: Decodable {
    let width, height: Int
}

struct FoodConfigDTO: Decodable {
    let mass: Double
}
