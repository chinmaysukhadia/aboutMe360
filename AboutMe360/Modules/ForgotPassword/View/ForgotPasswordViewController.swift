//
//  ForgotPasswordViewController.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 9/11/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: BaseViewController {

    //MARK: - IBOutlets
    
    @IBOutlet weak var txtMobileNumber: ACFloatingTextfield!
    @IBOutlet weak var imageViewMobileCheck: UIImageView!

    //MARK: - Variables
    
    var dataDict: [String: String] = [:]
    var forgotPasswordViewModel: ForgotPasswordViewModel?

    
    var mobileNumer:String? {
        didSet {
            self.dataDict[Constants.Keys.kMobileNumer] = mobileNumer
            mobileNumerValidtion()
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
        self.imageViewMobileCheck.isHidden = true
        self.txtMobileNumber.addDoneButtonOnKeyboard()
        self.setUpViewModel()
    }
    
    private func mobileNumerValidtion() {
        if let mobileNumer = self.mobileNumer , mobileNumer.count > 9 {
            self.imageViewMobileCheck.isHidden = false
        }else {
            self.imageViewMobileCheck.isHidden = true
        }
    }
    
    // Model Initialization
    private func setUpViewModel() {
        forgotPasswordViewModel = ForgotPasswordViewModel()
    }
    
    // API Call
    private func forgotPasswordAPI() {
        
        self.forgotPasswordViewModel?.validateForgotPasswordFormData(dataDict: self.dataDict) { (success, message) in
            if !success {
                Utilities.showToast(message: message)
            } else {
                
                self.forgotPasswordViewModel?.forgotPasswordAPI(paramDict: self.dataDict,completion: { (_, success) in
                    
                    if success {
                        Threads.performTaskInMainQueue {
                           
                            guard let verificationVC = DIConfigurator.verificationViewController() as? VerificationViewController  else {
                                return
                            }
                            verificationVC.verificationType = .forgotPassword
                            verificationVC.mobileNumber = self.txtMobileNumber.text?.trim()
                            self.navigationController?.pushViewController(verificationVC, animated: true)
                        }
                    }
                })
            }
        }
        
    }
    
    //MARK: - IBAction
    
    @IBAction func sendOTPButtonTapped(_ sender: Any) {
        self.view.endEditing(true)
        self.forgotPasswordAPI()
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}

extension ForgotPasswordViewController: UITextFieldDelegate {
    
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
            default:
                print("#####")
            }
        }
        return true
    }
}
