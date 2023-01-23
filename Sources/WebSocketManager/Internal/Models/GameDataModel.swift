//
//  File.swift
//  
//
//  Created by Maxim on 03.07.2022.
//

import Foundation

struct GameDataModel: Decodable {
    let key: String?
    let data: DataClass?
}

struct DataClass: Decodable {
    let lastReceivedTick, tick: Int?
    let cells: [CellDTO]?
    let food: [FoodDataDTO]?
}

struct CellDTO: Decodable {
    let id: String
    let isNew: Bool?
    let player: String?
    let mass: Double?
    let canSplit: Bool?
    let radius: Double?
    let velocity: CoordinatesDTO?
    let speed: Double?
    let direction: CoordinatesDTO?
    let availableEnergy, eatEfficiency: Double?
    let maxSpeed: Double?
    let power, volatilization: Double?
    let mergeTimer: Int?
    let canMerge: Bool?
    let position: CoordinatesDTO?
    let own: Bool?
    let del: Bool?
}

struct FoodDataDTO: Decodable {
    let id: String
    let isNew: Bool?
    let position: CoordinatesDTO?
    let del: Bool?
}

struct CoordinatesDTO: Decodable {
    let x: Double
    let y: Double
}
