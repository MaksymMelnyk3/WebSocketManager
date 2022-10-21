//
//  File.swift
//  
//
//  Created by Maxim on 01.10.2022.
//

import Foundation


extension Cell {
    mutating func update(cell: Cell) {
        if cell.canMerge != nil {
            self.canMerge = cell.canMerge
        }
        if cell.id != nil {
            self.id = cell.id
        }
        if cell.player != nil {
            self.player = cell.player
        }
        if cell.mass != nil {
            self.mass = cell.mass
        }
        if cell.canSplit != nil {
            self.canSplit = cell.canSplit
        }
        if cell.radius != nil {
            self.radius = cell.radius
        }
        if cell.velocity?.x != nil {
            self.velocity?.x = cell.velocity?.x
        }
        if cell.velocity?.y != nil {
            self.velocity?.y = cell.velocity?.y
        }
        if cell.speed != nil {
            self.speed = cell.speed
        }
        if cell.direction?.x != nil {
            self.direction?.x = cell.direction?.x
        }
        if cell.direction?.y != nil {
            self.direction?.y = cell.direction?.y
        }
        if cell.availableEnergy != nil {
            self.availableEnergy = cell.availableEnergy
        }
        if cell.eatEfficiency != nil {
            self.eatEfficiency = cell.eatEfficiency
        }
        if cell.maxSpeed != nil {
            self.maxSpeed = cell.maxSpeed
        }
        if cell.power != nil {
            self.power = cell.power
        }
        if cell.volatilization != nil {
            self.volatilization = cell.volatilization
        }
        if cell.mergeTimer != nil {
            self.mergeTimer = cell.mergeTimer
        }
        if cell.position?.x != nil {
            self.position?.x = cell.position?.x
        }
        if cell.position?.y != nil {
            self.position?.y = cell.position?.y
        }
        if cell.own != nil {
            self.own = cell.own
        }
        if cell.del != nil {
            self.del = cell.del
        }
    }
}

extension FoodData {
    mutating func update(food: FoodData) {
        if food.id != nil {
            self.id = food.id
        }
        if food.isNew != nil {
            self.isNew = food.isNew
        }
        if food.position?.x != nil {
            self.position?.x = food.position?.x
        }
        if food.position?.y != nil {
            self.position?.y = food.position?.y
        }
        if food.del != nil {
            self.del = food.del
        }
    }
}
