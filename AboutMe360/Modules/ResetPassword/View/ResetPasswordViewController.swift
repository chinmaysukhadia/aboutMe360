//
//  ResetPasswordViewController.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 13/09/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import UIKit

class ResetPasswordViewController: BaseViewController {

    //MARK: - IBOutlets
    
    @IBOutlet weak var txtPassword: ACFloatingTextfield!
    @IBOutlet weak var showPasswordButton: UIButton!

    //MARK: - Variables
    
    var dataDict: [String: String] = [:]
    var authDict: [String: String] = [:]
    var mobileNumber: String?
    var otp: String?
    var resetPasswordViewModel: ResetPasswordViewModel?

    var password:String? {
        didSet {
            self.authDict[Constants.Keys.kPassword] = password
        }
    }
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.setUp()
    }
    
    //MARK: - Private Methods
    
    private func setUp() {
        self.txtPassword.delegate =  self
        self.txtPassword.isSecureTextEntry = true
        self.authDict[Constants.Keys.kOtp] = otp
        self.dataDict[Constants.Keys.kMobileNumer] = mobileNumber
        self.setUpViewModel()
    }
    
    // Model Initialization
    private func setUpViewModel() {
        resetPasswordViewModel = ResetPasswordViewModel()
    }
    
    // API Call
    private func resetAPI() {
        
        self.resetPasswordViewModel?.validateNewPasswordFormData(dataDict: self.authDict) { (success, message) in
            if !success {
                Utilities.showToast(message: message)
            } else {
                
                self.resetPasswordViewModel?.resetAPI(paramDict: self.dataDict, authDict: self.authDict,completion: { (_, success) in
                    
                    if success {
                        Threads.performTaskInMainQueue {
                            guard let resetVC = DIConfigurator.resetPasswordAleartViewController() as? ResetPasswordAleartViewController  else {
                                return
                            }
                            self.navigationController?.pushViewController(resetVC, animated: true)
                        }
                    }
                })
            }
        }
    }
    
    //MARK: - IBAction
    
    @IBAction func resetPasswordTapped(_ sender: Any) {
        self.view.endEditing(true)
        
        if let password = self.password, password.count > 7 {
           self.resetAPI()
            return
        }
        
        Utilities.showToast(message: StringConstants.passwordShouldBeBetween)
    }
    
    @IBAction func showPasswordTapped(_ sender: Any) {
        self.showPasswordButton.isSelected = !self.showPasswordButton.isSelected
        self.txtPassword.isSecureTextEntry = self.showPasswordButton.isSelected
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}


extension ResetPasswordViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text, let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            switch textField {
            case txtPassword:
                self.password = updatedText
                if updatedText.count>Constants.ValidationsLength.passwordNumberMaxLength {
                    return false
                }
            default:
                print("#####")
            }
        }
        return true
    }
}
