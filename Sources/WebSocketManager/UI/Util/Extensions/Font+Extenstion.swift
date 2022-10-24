//
//  File.swift
//  
//
//  Created by Maxim Melnik on 24.10.2022.
//

import Foundation
import SwiftUI

#if canImport(UIKit)

extension UIFont {

    static func registerFont(bundle: Bundle, fontName: String, fontExtension: String, fontFamilyName: String = "SF PRO Rounded") -> Bool {



        let fontNames = UIFont.fontNames(forFamilyName: fontFamilyName)



        if fontNames.contains(fontName) {

            print("Font \(fontName) was already registered.")

            return false

        }



        guard let fontURL = bundle.url(forResource: fontName, withExtension: fontExtension) else {

            assertionFailure("Couldn't find font \(fontName)")

            return false

        }



        guard let fontDataProvider = CGDataProvider(url: fontURL as CFURL) else {

            assertionFailure("Couldn't load data from the font \(fontName)")

            return false

        }



        guard let font = CGFont(fontDataProvider) else {

            assertionFailure("Couldn't create font from data")

            return false

        }



        var error: Unmanaged<CFError>?

        let success = CTFontManagerRegisterGraphicsFont(font, &error)

        guard success else {

            print("Error registering font: maybe it was already registered.")

            return false

        }

        print("font was registred")

        return true

    }

    static public func registerFonts() {

        _ = UIFont.registerFont(bundle: .module, fontName: "SF-Pro-Rounded-Bold", fontExtension: "ttf")
        
    }

}

#endif
