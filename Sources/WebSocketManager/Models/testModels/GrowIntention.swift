//
//  File.swift
//  
//
//  Created by Maxim on 14.07.2022.
//

import Foundation

public struct GrowIntention{
    public var eatEfficiency: Double?
    public var maxSpeed: Double?
    public var power: Double?
    public var mass: Double?
    public var volatilization: Double?
    
    public init(eatEfficiency: Double, maxSpeed: Double, power: Double, mass: Double, volatilization: Double){
        self.eatEfficiency = eatEfficiency
        self.maxSpeed = maxSpeed
        self.power = power
        self.mass = mass
        self.volatilization = volatilization
    }
}
