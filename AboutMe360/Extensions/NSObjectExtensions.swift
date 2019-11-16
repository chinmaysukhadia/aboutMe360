//
//  NSObjectExtensions.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 12/09/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import Foundation

extension NSObject {
    
    class var className: String {
        return String(describing: self)
    }
}

