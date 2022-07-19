//
//  File.swift
//  
//
//  Created by Maxim on 14.07.2022.
//

import Foundation

public struct CellActivity {
    public var cellId: CellId
    public var speed: Double = 0.0

    public var velocity: Velocity?
    public var growIntention: GrowIntention?
}
