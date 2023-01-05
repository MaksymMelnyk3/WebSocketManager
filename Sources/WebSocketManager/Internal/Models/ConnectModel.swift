//
//  File.swift
//  
//
//  Created by Anastasiia Spiridonova on 05.01.2023.
//

import Foundation

struct ConnectModel: Encodable {
    let key = "connect_to_room"
    let data: ConnectDataModel
}

struct ConnectDataModel: Encodable {
    let roomName: String
    let watch: Bool
}
