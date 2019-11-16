//
//  DictionaryExtensions.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 9/22/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import Foundation

extension Dictionary {
    var queryString: String {
        var output: String = ""
        for (key,value) in self {
            output +=  "\(key)=\(value)&"
        }
        //output = String(output.characters.dropLast())
        return output
    }
}
