//
//  File.swift
//  
//
//  Created by Maxim Melnik on 23.10.2022.
//

import Foundation
import SwiftUI

@available(iOS 13.0, *)
func SCImage(named name: String) -> Image {
  Image(name, bundle: Bundle.module)
}

@available(iOS 13.0, *)
func SCColor(named name: String) -> Color {
    Color(name, bundle: Bundle.module)
}

