//
//  File.swift
//  
//
//  Created by Maxim on 26.07.2022.
//

import Foundation


struct PlayerAction: Codable {
    let key: String
    let data: PlayerData
}

// MARK: - DataClass
struct PlayerData: Codable {
    let cells: [PlayerCell]
}

// MARK: - Cell
struct PlayerCell: Codable {
    let id: String
    let velocity: PlayerVelocity
    let speed: Double
    let growIntention: PlayerGrowIntention
}

// MARK: - GrowIntention
struct PlayerGrowIntention: Codable {
    let eatEfficiency: Double
    let maxSpeed: Double
    let power: Double
    let mass, volatilization: Double
}

// MARK: - Velocity
struct PlayerVelocity: Codable {
    let x, y: Double
}
