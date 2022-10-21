//
//  File.swift
//  
//
//  Created by Maxim on 14.07.2022.
//

import Foundation

public struct CellActivity: Codable {
    public var id: String
    public var speed: Double? = 0.0

    public var velocity: Velocity?
    public var growIntention: GrowIntention?
    public var additionalAction: AdditionalAction?
    
    public init(cellId: String, speed: Double? = nil, velocity: Velocity? = nil, growIntention: GrowIntention? = nil, additionalAction: AdditionalAction? = nil ){
        self.id = cellId
        self.speed = speed
        self.velocity = velocity
        self.growIntention = growIntention
        self.additionalAction = additionalAction
    }
}
