//
//  UITableViewExtensions.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 12/09/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Methods
public extension UITableView {
    
    func register(nibName: String) {
        let nib = UINib(nibName: nibName, bundle: nil)
        self.register(nib, forCellReuseIdentifier: nibName)
    }
    
    func register(nibs: [String]) {
        for nibName in nibs {
            register(nibName: nibName)
        }
    }
}
