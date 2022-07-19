//
//  File.swift
//  
//
//  Created by Maxim on 14.07.2022.
//

import Foundation

public struct Velocity {
    public var x: Double?
    public var y: Double?

    public func moveToPosition(target: Position) -> Velocity {
        let fromX = self.x
        let fromY = self.y
        let targetX = target.x
        let targetY = target.y
        return Velocity(x: targetX - fromX!, y: targetY - fromY!)
    }
}
