//
//  OtpTextField.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 13/09/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import Foundation
import UIKit

protocol OTPTextFieldDelegate: UITextFieldDelegate {
    func backspacePressed(textField: UITextField)
}

class OTPTextField: UITextField {
    
    override func deleteBackward() {
        super.deleteBackward()
        guard let otpDelete = self.delegate as? OTPTextFieldDelegate else { return }
        otpDelete.backspacePressed(textField: self)
    }
}
