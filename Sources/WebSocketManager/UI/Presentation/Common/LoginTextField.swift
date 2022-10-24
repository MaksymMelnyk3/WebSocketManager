//
//  SwiftUIView.swift
//  
//
//  Created by Maxim Melnik on 21.10.2022.
//

import SwiftUI

@available(iOS 13.0, *)
struct LoginTextField: View {
    @Binding var text: String
    var body: some View {
        TextField("Login", text: $text)
            .padding([.leading, .trailing], 16)
            .padding([.top, .bottom], 11)
            .background(RoundedRectangle(cornerRadius: 8)
                .foregroundColor(Color.white.opacity(0.75)))
    }
}
@available(iOS 13.0.0, *)
struct LoginTextField_Previews: PreviewProvider {
    static var previews: some View {
        LoginTextField(text: .constant(""))
    }
}
