//
//  UIFont+extension.swift
//  PDKit
//
//  Created by Luis Angel Inga Mendoza on 13/03/23.
//

import UIKit

extension UIFont {
    
    enum RegisterFontError: Error {
        
        case invalidFontFile
        case fontPathNotFound
        case initFontError
        case registerFailed
        
    }
    
    private static var fontsRegistered: Bool = false
    
    public static func loadRDCustomFonts() {
        guard !fontsRegistered else { return }
        for font in PDFonts.allCases {
            do {
                try registerFont(fileNameString: font.rawValue, type: "ttf")
            } catch let error {
                fatalError("Failed to register - cause: \(error)")
            }
        }
        fontsRegistered = true
    }
    
    private static func registerFont(fileNameString: String, type: String) throws {
        let frameworkBundle = Bundle.generatePDBundle()
        guard let resourceBundleURL = frameworkBundle.path(forResource: fileNameString, ofType: type) else {
            throw RegisterFontError.fontPathNotFound
        }
        guard let fontData = NSData(contentsOfFile: resourceBundleURL),
              let dataProvider = CGDataProvider.init(data: fontData) else {
            throw RegisterFontError.invalidFontFile
        }
        guard let fontRef = CGFont.init(dataProvider) else {
            throw RegisterFontError.initFontError
        }
        var errorRef: Unmanaged<CFError>? = nil
        guard CTFontManagerRegisterGraphicsFont(fontRef, &errorRef) else {
            throw RegisterFontError.registerFailed
        }
    }
    
}

