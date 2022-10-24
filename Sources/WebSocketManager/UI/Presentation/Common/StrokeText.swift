//
//  File.swift
//  
//
//  Created by Maxim Melnik on 21.10.2022.
//

import SwiftUI

@available(iOS 13.0, *)
struct StrokeTextLabel: UIViewRepresentable {
    func makeUIView(context: Context) -> UILabel {
        let attributedStringParagraphStyle = NSMutableParagraphStyle()
        attributedStringParagraphStyle.alignment = NSTextAlignment.center
        let attributedString = NSAttributedString(
            string: "KUS’",
            attributes:[
                NSAttributedString.Key.paragraphStyle: attributedStringParagraphStyle,
                NSAttributedString.Key.strokeWidth: 2.0,
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.strokeColor: UIColor.white,
                NSAttributedString.Key.font: UIFont(name: "SFRounded-Ultralight", size: 60)!
            ]
        )

        let strokeLabel = UILabel(frame: CGRect.zero)
        strokeLabel.attributedText = attributedString
        strokeLabel.backgroundColor = UIColor.clear
        strokeLabel.sizeToFit()
        strokeLabel.center = CGPoint.init(x: 0.0, y: 0.0)
        return strokeLabel
    }

    func updateUIView(_ uiView: UILabel, context: Context) {}
}
