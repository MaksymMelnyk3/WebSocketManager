//
//  File.swift
//  
//
//  Created by Maxim on 14.07.2022.
//

import Foundation

public struct DesiredCellsState {
    public var myCells: [CellActivity]
    
    public init(cell: [CellActivity]) {
        self.myCells = cell
    }
}
