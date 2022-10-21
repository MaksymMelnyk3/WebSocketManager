//
//  File.swift
//  
//
//  Created by Maxim on 04.08.2022.
//

import Foundation


public struct AdditionalAction: Codable {
    public var split: Bool?
    public var merge: String?
    
    
    public init(split: Bool?, merge: String? ) {
        self.split = split
        self.merge = merge
    }
}
