//
//  SwiftUIView.swift
//  
//
//  Created by Maxim Melnik on 21.10.2022.
//

import SwiftUI
@available(iOS 13.0.0, *)
struct MainScreenView: View {
    
    @ObservedObject private var viewModel = ViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            StrokeTextLabel()
                .frame(height: 41)
            Text("game")
                .foregroundColor(.green)
                .padding(.top, 5)
                .font(Font.custom("SFRounded-Ultralight", size: 17))
            SCImage(named: "person")
                .frame(width: 150, height: 150)
                .padding(.top, 53.5)
            LoginTextField(text: $viewModel.textField)
                .padding(.top, 124)
                .padding(.bottom, 20)
            StartButton {
                
            }
        }
        .padding(.bottom, 180)
        .padding(.top, 133.5)
        .padding([.leading, .trailing], 16)
        .background(
            SCImage(named: "background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
        )
    }}

struct SwiftUIView_Previews: PreviewProvider {
    @available(iOS 13.0.0, *)
    static var previews: some View {
        MainScreenView()
    }
}
