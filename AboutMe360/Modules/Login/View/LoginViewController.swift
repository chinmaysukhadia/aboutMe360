//
//  LoginViewController.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 9/11/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import UIKit
import SwiftyUserDefaults
class LoginViewController: BaseViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var txtMobileNumber: ACFloatingTextfield!
    @IBOutlet weak var txtPassword: ACFloatingTextfield!
    @IBOutlet weak var imageViewMobileCheck: UIImageView!
    @IBOutlet weak var showPasswordButton: UIButton!
    
    //MARK: - Variables
    
    var dataDict: [String: String] = [:]
    var loginViewModel: LoginViewModel?
    
    var mobileNumer:String? {
        didSet {
            self.dataDict[Constants.Keys.kMobileNumer] = mobileNumer
            mobileNumerValidtion()
        }
    }
    
    var password:String? {
        didSet {
            self.dataDict[Constants.Keys.kPassword] = password
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
        self.txtMobileNumber.delegate =  self
        self.txtPassword.delegate =  self
        self.imageViewMobileCheck.isHidden = true
        self.txtPassword.isSecureTextEntry = true
        self.txtMobileNumber.addDoneButtonOnKeyboard()
        self.setUpViewModel()
    }
    
    // Model Initialization
    private func setUpViewModel() {
        loginViewModel = LoginViewModel()
    }
    
    private func mobileNumerValidtion() {
        if let mobileNumer = self.mobileNumer , mobileNumer.count > 9 {
            self.imageViewMobileCheck.isHidden = false
        }else {
            self.imageViewMobileCheck.isHidden = true
        }
    }
   
    // API Call
    private func loginAPI() {
        
        self.loginViewModel?.validateLoginFormData(loginDataDict: self.dataDict) { (success, message) in
            if !success {
                Utilities.showToast(message: message)
            } else {
                
                self.loginViewModel?.loginAPI(authDict: self.dataDict,completion: { (_, success) in
                    
                    if success {
                        
                        self.loginViewModel?.profileAPI(authDict: self.dataDict, param: [Constants.Keys.kUserID: "" as AnyObject],completion: { (data, success) in
                            
                            if success {
                                Defaults[.profleData] = data as? HomeModel
                                Threads.performTaskInMainQueue {
                                    AppDelegate.delegate()?.showTabBar()
                                }
                            }
                        })
                    }
                })
            }
        }
        
    }
    
    //MARK: - IBAction
    
    @IBAction func showPasswordTapped(_ sender: Any) {
        self.showPasswordButton.isSelected = !self.showPasswordButton.isSelected
        self.txtPassword.isSecureTextEntry = self.showPasswordButton.isSelected
    }
    
    @IBAction func forgotButtonPasswordTapped(_ sender: Any) {
        
        guard let forgotPasswordVC = DIConfigurator.forgotPasswordViewController() as? ForgotPasswordViewController  else {
            return
        }
        self.navigationController?.pushViewController(forgotPasswordVC, animated: true)
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        // AppDelegate.delegate()?.showTabBar()
        self.view.endEditing(true)
        self.loginAPI()
    }
    
    @IBAction func signupButtonTapped(_ sender: Any) {
        
        guard let signUpVC = DIConfigurator.signUpViewController() as? SignUpViewController  else {
            return
        }
        self.navigationController?.pushViewController(signUpVC, animated: true)
       
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text, let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            switch textField {
            case txtMobileNumber:
                self.mobileNumer = updatedText
                if updatedText.count>Constants.ValidationsLength.mobileNumberMaxLength {
                    return false
                }
            case txtPassword:
                self.password = updatedText
                if updatedText.count>Constants.ValidationsLength.maxPasswordLength {
                    return false
                }
            default:
                print("#####")
            }
            
        }
        return true
    }
}
