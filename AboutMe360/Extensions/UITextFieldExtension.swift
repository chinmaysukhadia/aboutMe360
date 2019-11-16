//
//  UITextFieldExtension.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 12/09/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {

    func addDoneButtonOnKeyboard(_ showCancelButton: Bool = false) {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonTapped))
        
        var items = [flexSpace, done]
        if showCancelButton {
            let cancel: UIBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancelButtonTapped))
            items = [cancel, flexSpace, done]
        }
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonTapped() {
        self.resignFirstResponder()
    }
    
    @objc func cancelButtonTapped() {
        self.resignFirstResponder()
    }
    
    func setLeftPadding(padding: CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPadding(padding: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
