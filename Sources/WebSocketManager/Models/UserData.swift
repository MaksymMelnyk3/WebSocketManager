//
//  File.swift
//  
//
//  Created by Maxim on 26.09.2022.
//

import Foundation


public struct UserData{
    var tick: Int
    var lastResivedTick: Int
    var food: [FoodData]
    var cell: [Cell]
    
    init(food: [FoodData], cell: [Cell], tick: Int, lastResivedTick: Int){
        self.food = food
        self.cell = cell
        self.tick = tick
        self.lastResivedTick = lastResivedTick
    }
}
