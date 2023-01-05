//
//  File.swift
//  
//
//  Created by Anastasiia Spiridonova on 03.01.2023.
//

import Foundation

public struct CellActivity {
    let id: String
    let speed: Double?
    
    let velocity: Coordinates?
    let growIntention: GrowIntention?
    let additionalAction: AdditionalAction?
    
    public init(
        cellId: String,
        speed: Double? = nil,
        velocity: Coordinates? = nil,
        growIntention: GrowIntention? = nil,
        additionalAction: AdditionalAction? = nil
    ) {
        self.id = cellId
        self.speed = speed
        self.velocity = velocity
        self.growIntention = growIntention
        self.additionalAction = additionalAction
    }
}

public struct GrowIntention {
    let eatEfficiency: Double?
    let maxSpeed: Double?
    let power: Double?
    let mass: Double?
    let volatilization: Double?
    
    public init(
        eatEfficiency: Double? = nil,
        maxSpeed: Double? = nil,
        power: Double? = nil,
        mass: Double? = nil,
        volatilization: Double? = nil
    ) {
        self.eatEfficiency = eatEfficiency
        self.maxSpeed = maxSpeed
        self.power = power
        self.mass = mass
        self.volatilization = volatilization
    }
}


public struct AdditionalAction {
    let split: Bool?
    let merge: String?
    
    public init(split: Bool?, merge: String? ) {
        self.split = split
        self.merge = merge
    }
}
