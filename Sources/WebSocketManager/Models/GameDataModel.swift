//
//  File.swift
//  
//
//  Created by Maxim on 03.07.2022.
//

import Foundation

struct GameDataModel: Codable {
    let key: String?
    let data: DataClass?
}

struct DataClass: Codable {
    let lastReceivedTick, tick: Int?
    let cells: [Cell]?
    let food: [FoodData]?
}

struct Cell: Codable {
    let id: String?
    let isNew: Bool?
    let player: String?
    let mass: Int?
    let canSplit: Bool?
    let radius: Double?
    let velocity: Direction?
    let speed: Int?
    let direction: Direction?
    let availableEnergy, eatEfficiency: Double?
    let maxSpeed: Int?
    let power, volatilization: Double?
    let mergeTimer: Int?
    let canMerge: Bool?
    let position: Direction?
    let own: Bool?
}

struct Direction: Codable {
    let x, y: Double?
}

struct FoodData: Codable {
    let id: String?
    let isNew: Bool?
    let position: Direction?
}
