//
//  SwiftUIView.swift
//  
//
//  Created by Maxim Melnik on 21.10.2022.
//

import SwiftUI

@available(iOS 13.0.0, *)
struct StartButton: View {
    var action: () -> Void
    var body: some View {
        Button {
            action()
        } label: {
            Text("START")
                .frame(minWidth: 0, maxWidth: .infinity)
                .font(.system(size: 17))
                .foregroundColor(Color.white)
        }
        .padding([.top, .bottom], 11)
        .background(SCColor(named: "GreenButtonColor"))
            .cornerRadius(8)
    }
}

@available(iOS 13.0.0, *)
struct StartButton_Previews: PreviewProvider {
    static var previews: some View {
        StartButton(action: {})
    }
}

