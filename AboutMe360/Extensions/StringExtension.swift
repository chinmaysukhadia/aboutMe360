//
//  StringExtension.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 12/09/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import Foundation
import UIKit

private let Nunito = "Nunito"

enum Font {

    case nunito(_ fontStyle: FontStyle)

    enum FontStyle: String {
        case bold = "Bold"
        case semibold = "Semibold"
        case regular = "Regular"
    }

    var fontFullName: String {
        switch self {
        case .nunito(let fontStyle):
            return Nunito+"-"+fontStyle.rawValue
        }
    }

    func size(_ size: CGFloat) -> UIFont {
        if let font = UIFont(name: fontFullName, size: size + 1.0) {
            return font
        }
        fatalError("Font '\(fontFullName)' does not exist.")
    }
}

extension String {
  
    func trim() -> String {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
}


extension NSMutableAttributedString {
    @discardableResult func bold(_ text: String , font: UIFont = Font.nunito(.bold).size(18) , _ isAddColor: Bool = false) -> NSMutableAttributedString {
        if isAddColor == true {
            let color = UIColor(displayP3Red: 66/255, green: 179/255, blue: 252/255, alpha: 1)
            let attrs: [NSAttributedString.Key: Any] = [.font: font , .foregroundColor: color]
            let boldString = NSMutableAttributedString(string:text, attributes: attrs)
            append(boldString)
            return self
        } else {
            let attrs: [NSAttributedString.Key: Any] = [.font: font]
            let boldString = NSMutableAttributedString(string:text, attributes: attrs)
            append(boldString)
            return self
        }
    }
    
    @discardableResult func normal(_ text: String, font: UIFont = Font.nunito(.semibold).size(16) , _ isAddColor: Bool = false ) -> NSMutableAttributedString {
        if isAddColor == true {
            let color = UIColor(displayP3Red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
            let attrs: [NSAttributedString.Key: Any] = [.font: font , .foregroundColor: color]
            let normal = NSMutableAttributedString(string:text, attributes: attrs)
            append(normal)
            return self
        }else {
            let attrs: [NSAttributedString.Key: Any] = [.font: font]
            let normal = NSMutableAttributedString(string:text, attributes: attrs)
            append(normal)
            return self
        }
    }
}
