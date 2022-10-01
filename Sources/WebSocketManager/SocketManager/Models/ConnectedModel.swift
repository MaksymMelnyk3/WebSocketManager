//
//  File.swift
//  
//
//  Created by Maxim on 28.06.2022.
//

import Foundation

struct ConnectedModel: Decodable {
    let key: String?
    let data: DataConnect?
}

struct DataConnect: Codable {
    let playerID: String?
    
    enum CodingKeys: String, CodingKey {
        case playerID = "player_id"
    }
}
