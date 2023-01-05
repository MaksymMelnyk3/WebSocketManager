//
//  File.swift
//  
//
//  Created by Maxim on 03.07.2022.
//

import Foundation

struct KeyModel: Decodable {
    let key: String?
}

enum Keys: String {
    case connected = "connected"
    case config = "game_config"
    case data = "game_data"
}
