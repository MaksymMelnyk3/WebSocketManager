//
//  File.swift
//  
//
//  Created by Maxim on 26.09.2022.
//

import Foundation


public struct MapState{
    public var tick: Int
    public var lastResivedTick: Int
    public var food: [FoodData]
    public var cell: [Cell]
    
    init(food: [FoodData], cell: [Cell], tick: Int, lastResivedTick: Int){
        self.food = food
        self.cell = cell
        self.tick = tick
        self.lastResivedTick = lastResivedTick
    }
}
