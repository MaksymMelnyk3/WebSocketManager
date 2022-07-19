//
//  File.swift
//  
//
//  Created by Maxim on 03.07.2022.
//

import Foundation

public struct GameConfigModel: Codable {
    let key: String?
    let data: DataConfig?
}

struct DataConfig: Codable {
    let tickTime, ticksLimit: Int?
    let map: Map?
    let cell: [String: Double]?
    let food: FoodConfig?
}

struct FoodConfig: Codable {
    let mass: Double?
}

struct Map: Codable {
    let width, height: Int?
}

