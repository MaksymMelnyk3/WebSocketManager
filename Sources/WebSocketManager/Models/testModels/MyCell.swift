//
//  File.swift
//  
//
//  Created by Maxim on 14.07.2022.
//

import Foundation


public struct MyCell {
    
    public var cellId: CellId
    public var property: CellProperty
    
    public var availableEnergy: Double
    public var canSplit: Bool
    public var canMerge: Bool

    public var mergeTimer: Int
    
}

