//
//  File.swift
//  
//
//  Created by Maxim on 03.07.2022.
//

import Foundation

public struct GameDataModel: Codable {
    public let key: String?
    public let data: DataClass?
}

public struct DataClass: Codable {
    public let lastReceivedTick, tick: Int?
    public let cells: [Cell]?
    public let food: [FoodData]?
}

public struct Cell: Codable {
    public let id: String?
    public let isNew: Bool?
    public let player: String?
    public let mass: Int?
    public let canSplit: Bool?
    public let radius: Double?
    public let velocity: Velocity?
    public let speed: Double?
    public let direction: Position?
    public let availableEnergy, eatEfficiency: Double?
    public let maxSpeed: Int?
    public let power, volatilization: Double?
    public let mergeTimer: Int?
    public let canMerge: Bool?
    public let position: Position?
    public let own: Bool?
}


public struct FoodData: Codable {
    public let id: String?
    public let isNew: Bool?
    public let position: Position?
}

public struct Position: Codable {
    public var x: Double?
    public var y: Double?
    
    public init (x: Double, y: Double){
        self.x = x
        self.y = y
    }
    
    public func distanceToPosition(target: Position) -> Double {
        return distanceBetweenPoints(position1: self, position2: target)
    }

    func distanceBetweenPoints(position1: Position, position2: Position) -> Double {
        guard let x1 = position1.x,
              let y1 = position1.y,
              let x2 = position2.x,
              let y2 = position2.y
        else { return 0}
        return distanceBetweenPoints(x1: x1, y1: y1, x2: x2, y2: y2)
    }

    func distanceBetweenPoints(x1: Double, y1: Double, x2: Double, y2: Double) -> Double {
        return sqrt(((y2 - y1) * (y2 - y1) + (x2 - x1) * (x2 - x1)))
    }
}

public struct Velocity: Codable {
    public var x: Double?
    public var y: Double?
    
    public init (x: Double, y: Double){
        self.x = x
        self.y = y
    }

    public func moveToPosition(target: Position) -> Velocity {
        guard let targetX = target.x,
              let targetY = target.y,
              let fromX = self.x,
              let fromY = self.y
        else { return Velocity(x: 0, y: 0)}
        return Velocity(x: targetX - fromX, y: targetY - fromY)
    }
}
