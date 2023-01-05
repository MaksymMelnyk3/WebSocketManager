//
//  File.swift
//  
//
//  Created by Maxim on 14.07.2022.
//

import Foundation

struct CellActivityDTO: Encodable {
    let id: String
    let speed: Double?

    let velocity: VelocityDTO?
    let growIntention: GrowIntentionDTO?
    let additionalAction: AdditionalActionDTO?
    
    init(
        cellId: String,
        speed: Double? = nil,
        velocity: VelocityDTO? = nil,
        growIntention: GrowIntentionDTO? = nil,
        additionalAction: AdditionalActionDTO? = nil
    ) {
        self.id = cellId
        self.speed = speed
        self.velocity = velocity
        self.growIntention = growIntention
        self.additionalAction = additionalAction
    }
}

extension CellActivityDTO {
    struct VelocityDTO: Encodable {
        let x: Double
        let y: Double
        
        init?(x: Double?, y: Double?) {
            guard let x = x, let y = y
            else {
                return nil
            }
            self.x = x
            self.y = y
        }
    }
    
    struct GrowIntentionDTO: Encodable {
        let eatEfficiency: Double?
        let maxSpeed: Double?
        let power: Double?
        let mass: Double?
        let volatilization: Double?
        
        init(
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
    
    
    struct AdditionalActionDTO: Encodable {
        let split: Bool?
        let merge: String?
        
        init(split: Bool?, merge: String? ) {
            self.split = split
            self.merge = merge
        }
    }
}

