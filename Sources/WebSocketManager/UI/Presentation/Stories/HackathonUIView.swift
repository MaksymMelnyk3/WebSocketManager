//
//  SwiftUIView.swift
//  
//
//  Created by Maxim Melnik on 25.10.2022.
//

import SwiftUI

@available(iOS 13.0, *)
public struct HackathonUIView: View {
    
    public init() {
        UIFont.registerFonts()
    }
    
    public var body: some View {
        MainScreenView()
    }
}

@available(iOS 13.0, *)
struct HackathonUIView_Previews: PreviewProvider {
    static var previews: some View {
        HackathonUIView()
    }
}
