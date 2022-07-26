//
//  File.swift
//  
//
//  Created by Maxim on 14.07.2022.
//

import Foundation

public struct CellActivity {
    public var cellId: String
    public var speed: Double = 0.0

    public var velocity: Velocity?
    public var growIntention: GrowIntention?
    
    public init(cellId: String, speed: Double, velocity: Velocity, growIntention: GrowIntention ){
        self.cellId = cellId
        self.speed = speed
        self.velocity = velocity
        self.growIntention = growIntention
    }
}
