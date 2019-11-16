//
//  VerificationViewController.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 13/09/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

enum VerificationType {
    
    case none
    case signUp
    case forgotPassword
    case editProfile
    
    
    var title : String? {
        switch self {
        case .signUp:
            return "Verify your details"
        case .forgotPassword:
            return "Verify your account"
        case .none:
            return ""
        case .editProfile:
            return "Verify your number"
        }
    }
    
}

class VerificationViewController: BaseViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var mobileNumberLabel: UILabel!
    @IBOutlet weak var otpTextFieldOne: OTPTextField!
    @IBOutlet weak var otpTextFieldTwo: OTPTextField!
    @IBOutlet weak var otpTextFieldThree: OTPTextField!
    @IBOutlet weak var otpTextFieldFourth: OTPTextField!
    @IBOutlet weak var changeButton: UIButton!
    
    //MARK: - Variables
    
    var verificationType : VerificationType = .none
    var forgotPasswordViewModel: ForgotPasswordViewModel?
    var verificationViewModel: VerificationViewModel?
    var signUpViewModel: SignUpViewModel?
    var editProfileViewModel: EditProfileViewModel?
    
    var timer: Timer?
    var timeRemaining = 180
    var mobileNumber: String?
    var paramsDict = [String: String]()
    var otp: String?
    var callBack: (() ->Void)?
    let yourAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: color.appDarkBlueColor,
                                                         .underlineStyle: NSUnderlineStyle.single.rawValue]
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.setUp()
    }
    
    //MARK: - Private Methods
    
    private func setUp() {
        
        self.titleLabel.text = verificationType.title
        if let mobileNumber = mobileNumber {
            self.mobileNumberLabel.text = mobileNumber
        }
        self.runTimer()
        setuptag()
        setUpDelegate()
        self.setUpViewModel()
        
        let attributeString = NSMutableAttributedString(string: StringConstants.change,
                                                        attributes: yourAttributes)
        changeButton.setAttributedTitle(attributeString, for: .normal)
        self.otpTextFieldOne.addDoneButtonOnKeyboard()
        self.otpTextFieldTwo.addDoneButtonOnKeyboard()
        self.otpTextFieldThree.addDoneButtonOnKeyboard()
        self.otpTextFieldFourth.addDoneButtonOnKeyboard()
    }
    
    private func setuptag() {
        otpTextFieldOne.tag = 0
        otpTextFieldTwo.tag = 1
        otpTextFieldThree.tag = 2
        otpTextFieldFourth.tag = 3
    }
    
    private func setUpDelegate() {
        otpTextFieldOne.delegate = self
        otpTextFieldTwo.delegate = self
        otpTextFieldThree.delegate = self
        otpTextFieldFourth.delegate = self
    }
    
    // Model Initialization
    private func setUpViewModel() {
        forgotPasswordViewModel = ForgotPasswordViewModel()
        verificationViewModel = VerificationViewModel()
        signUpViewModel = SignUpViewModel()
        editProfileViewModel = EditProfileViewModel()
    }
    
    func runTimer() {
        if timer != nil {
            timer = nil
        }
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerRunning), userInfo: nil, repeats: true)
    }
    
    @objc func timerRunning() {
        timeRemaining -= 1
        let minutesLeft = Int(timeRemaining) / 60 % 60
        let secondsLeft = Int(timeRemaining) % 60
        
        self.timerLabel.text = "- The OTP will expire in " + String(format:"%02i:%02i min.", minutesLeft, secondsLeft)
        let timeOut = String(format:"%02i:%02i", minutesLeft, secondsLeft)
        if timeOut == "00:00" {
            timer?.invalidate()
            self.view.endEditing(true)

            let alertController = UIAlertController(title: title, message: "The OTP you requested has expired now. Would you like to resend it?", preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction.init(title: "Cancel", style: UIAlertAction.Style.default, handler: { (action : UIAlertAction) in
                self.navigationController?.popViewController(animated: true)
            }))
            
            alertController.addAction(UIAlertAction.init(title: "Resend", style: UIAlertAction.Style.default, handler: { (action : UIAlertAction) in
                self.resendOTP()
            }))
            
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
    
    func resendOTP() {

        self.timerLabel.text = "- The OTP will expire in 03.00 min"
               otpTextFieldOne.text = ""
               otpTextFieldTwo.text = ""
               otpTextFieldThree.text = ""
               otpTextFieldFourth.text = ""
        
        if verificationType == .forgotPassword {
                   
                   let  dataDict = [Constants.Keys.kMobileNumer: mobileNumber]
                   
                   self.forgotPasswordViewModel?.forgotPasswordAPI(paramDict:dataDict as! [String : String],completion: { (_, success) in
                       
                       if success {
                           Threads.performTaskInMainQueue {
                               self.runTimer()
                           }
                       }
                   })
               } else  if verificationType == .signUp {
                   
                   self.signUpViewModel?.signUpAPI(paramDict: self.paramsDict,completion: { (_, success) in
                       
                   })
               } else {
                   
                   self.editProfileViewModel?.verifyUpdateProfileOTPAPI(paramDict: self.paramsDict,completion: { (otp, success) in
                       
                       self.otp = otp as? String
                   })
               }
    }
    
    // API Call
    private func verifyAPI(otp: String) {
        
        if verificationType == .forgotPassword {
            let dict = [Constants.Keys.kMobileNumer: self.mobileNumber,Constants.Keys.kOtp: otp]
            self.verificationViewModel?.verifyForgotPasswordAPI(paramDict: dict as! [String : String],completion: { (_, success) in
                
                if success {
                    Threads.performTaskInMainQueue {
                        guard let resetPasswordVC = DIConfigurator.resetPasswordViewController() as? ResetPasswordViewController  else {
                            return
                        }
                        resetPasswordVC.mobileNumber = self.mobileNumber
                        resetPasswordVC.otp = otp
                        self.navigationController?.pushViewController(resetPasswordVC, animated: true)
                    }
                }
            })
        } else if verificationType == .signUp {
            
            self.paramsDict[Constants.Keys.kOtp] = otp
            
            self.verificationViewModel?.verifySignOtpAPI(paramDict:self.paramsDict,completion: { (_, success) in
                
                if success {
                    Defaults[.isProfileCreated]  = true
                    Threads.performTaskInMainQueue {
                        guard let profilePictureViewC = DIConfigurator.profilePictureViewController() as? ProfilePictureViewController  else {
                            return
                        }
                        self.navigationController?.pushViewController(profilePictureViewC, animated: true)
                    }
                }
            })
        } else {
            
            if otp == self.otp {
                
                self.callBack?()
                self.navigationController?.popViewController(animated: true)
            } else {
                Utilities.showToast(message: StringConstants.invalidOtp)
            }
        }
    }
    
    //MARK: - IBAction
    
    @IBAction func verifyButtonTapped(_ sender: Any) {
        self.view.endEditing(true)
        timer?.invalidate()
        if let otpOne = otpTextFieldOne.text?.trim(),let otpTwo = otpTextFieldTwo.text?.trim(),let otpThree = otpTextFieldThree.text?.trim(),let otpFourth = otpTextFieldFourth.text?.trim()  {
            // Value requirements not met, do something
            let otp = otpOne + otpTwo + otpThree + otpFourth
            self.verifyAPI(otp: otp)
            return
        } else {
            Utilities.showToast(message: StringConstants.enter4DigitOTP)
        }
    }
    
    @IBAction func changeButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func resendButtonTapped(_ sender: Any) {
        
        self.view.endEditing(true)
        self.resendOTP()
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}


extension VerificationViewController : OTPTextFieldDelegate  {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //setupGradient(textField.tag)
        
        if string.isEmpty {
            textField.text = ""
            self.moveFarwordDirection(textField: textField, isForward: false)
        } else {
            let allowedCharacters = CharacterSet(charactersIn:"0123456789")
            let characterSet = CharacterSet(charactersIn: string)
            if allowedCharacters.isSuperset(of: characterSet) {
                textField.text = string
                self.moveFarwordDirection(textField: textField, isForward: true)
            }
        }
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == otpTextFieldOne {
            otpTextFieldTwo.becomeFirstResponder()
            return false
        } else if textField == otpTextFieldTwo {
            otpTextFieldThree.becomeFirstResponder()
            return false
        } else if textField == otpTextFieldThree {
            otpTextFieldFourth.becomeFirstResponder()
            return true
        } else {
            textField.resignFirstResponder()
        }
        
        return true
    }
    
    func backspacePressed(textField: UITextField) {
        self.moveFarwordDirection(textField: textField, isForward: false)
    }
    
    fileprivate func moveFarwordDirection(textField: UITextField, isForward: Bool) {
        
        switch textField {
        case otpTextFieldOne:
            if isForward {
                otpTextFieldTwo.becomeFirstResponder()
            }
        case otpTextFieldTwo:
            if isForward {
                
                otpTextFieldThree.becomeFirstResponder()
            } else {
                otpTextFieldOne.becomeFirstResponder()
            }
        case otpTextFieldThree:
            if isForward {
                otpTextFieldFourth.becomeFirstResponder()
                
            } else {
                otpTextFieldTwo.becomeFirstResponder()
            }
        case otpTextFieldFourth:
            if isForward {
                textField.resignFirstResponder()
            } else {
                otpTextFieldThree.becomeFirstResponder()
            }
        default: break
        }
    }
    
    func verifyOTP() {
        self.view.endEditing(true)
    }
}
