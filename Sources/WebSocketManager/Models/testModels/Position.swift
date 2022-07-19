//
//  File.swift
//  
//
//  Created by Maxim on 14.07.2022.
//

import Foundation


public struct Position {
    public var x: Double
    public var y: Double
    
    public func distanceToPosition(target: Position) -> Double {
        return distanceBetweenPoints(position1: self, position2: target)
    }

    func distanceBetweenPoints(position1: Position, position2: Position) -> Double {
        let x1 = position1.x
        let y1 = position1.y
        let x2 = position2.x
        let y2 = position2.y
        return distanceBetweenPoints(x1: x1, y1: y1, x2: x2, y2: y2)
    }

    func distanceBetweenPoints(x1: Double, y1: Double, x2: Double, y2: Double) -> Double {
        return sqrt(((y2 - y1) * (y2 - y1) + (x2 - x1) * (x2 - x1)))
    }
}
