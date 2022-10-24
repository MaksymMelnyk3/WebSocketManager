//
//  File.swift
//  
//
//  Created by Maxim Melnik on 21.10.2022.
//

import Foundation
import Combine


@available(iOS 13.0, *)
class ViewModel: ObservableObject {
    @Published var textField = ""
}
