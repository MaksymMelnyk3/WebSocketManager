//
//  File.swift
//  
//
//  Created by Maxim on 26.07.2022.
//

import Foundation


struct PlayerAction: Encodable {
    let key: String
    let data: PlayerData
}

// MARK: - DataClass
struct PlayerData: Encodable {
    let cells: [CellActivityDTO]
}
