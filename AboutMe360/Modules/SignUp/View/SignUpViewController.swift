//
//  SignUpViewController.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 9/11/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class SignUpViewController: BaseViewController,UITextViewDelegate {
    
    //MARK: - IBOUtlets
    
    @IBOutlet weak var signUpTableView: UITableView!
    @IBOutlet weak var checkBoxButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    
    //MARK: - Variables
    
    var dataDict:[String: String] = [:]
    /// var authDict: [String: String] = [:]
    var signUpViewModel: SignUpViewModel?
    
    var name: String? {
        didSet {
            dataDict[Constants.Keys.kName] = name
        }
    }
    
    var email: String? {
        didSet {
            dataDict[Constants.Keys.kEmail] = email
        }
    }
    
    var mobileNumber: String? {
        didSet {
            dataDict[Constants.Keys.kMobileNumer] = mobileNumber
        }
    }
    
    var password: String? {
        didSet {
            dataDict[Constants.Keys.kPassword] = password
        }
    }
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setuUp()
    }
    
    //MARK: - Private Methods
    
    private func setuUp() {
        registerCell()
        self.setUpViewModel()
        self.setUpTextView()
        
        self.signUpTableView.reloadData()
        self.signUpTableView.layoutIfNeeded()
        //        Threads.performTaskAfterDealy(0.1) {
        //            let numRows = self.tableView(self.signUpTableView, numberOfRowsInSection: 0)
        //            var contentInsetTop = self.signUpTableView.bounds.size.height
        //            for i in 0..<numRows {
        //                let rowRect = self.signUpTableView.rectForRow(at: IndexPath(item: i, section: 0))
        //                contentInsetTop -= rowRect.size.height
        //                if contentInsetTop <= 0 {
        //                    contentInsetTop = 0
        //                }
        //            }
        //
        //            //self.signUpTableView.contentInset = UIEdgeInsets(top: contentInsetTop,left: 0,bottom: 0,right: 0)
        //
        //            let view = UIView()
        //            view.frame.size.height = contentInsetTop
        //            self.signUpTableView.tableHeaderView = view
        //        }
        
    }
    
    private func registerCell() {
        signUpTableView.register(nibs: [OneTextFieldCell.className])
    }
    
    // Model Initialization
    private func setUpViewModel() {
        signUpViewModel = SignUpViewModel()
    }
    
    // API Call
    private func signupAPI() {
        
        self.signUpViewModel?.validateSignUpFormData(dataDict: self.dataDict) { (success, message) in
            if !success {
                Utilities.showToast(message: message)
            } else {
                
                if self.checkBoxButton.isSelected {
                    
                    self.signUpViewModel?.signUpAPI(paramDict: self.dataDict,completion: { (_, success) in
                        
                        if success {
                            Threads.performTaskInMainQueue {
                                guard let verificationVC = DIConfigurator.verificationViewController() as? VerificationViewController  else {
                                    return
                                }
                                verificationVC.verificationType = .signUp
                                verificationVC.mobileNumber = self.mobileNumber
                                verificationVC.paramsDict = self.dataDict
                                self.navigationController?.pushViewController(verificationVC, animated: true)
                            }
                        }
                    })
                } else {
                    Utilities.showToast(message:StringConstants.PleaseAcceptPrivacyPolicy)
                }
            }
        }
    }
    
    private func setUpTextView() {
        
        
        let text = NSMutableAttributedString(string: "I agree to AboutMe360’s ")
        
        let selectablePart = NSMutableAttributedString(string: "User Agreement and ")
        selectablePart.addAttribute(NSAttributedString.Key.font, value: textView.font as Any, range: NSMakeRange(0, selectablePart.length))
        selectablePart.addAttributes([NSAttributedString.Key.font: textView.font as Any,NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor.green ], range: NSMakeRange(0, selectablePart.length))
        selectablePart.addAttribute(NSAttributedString.Key.link, value: "http://www.aboutme360.com/terms-and-conditions.html", range: NSMakeRange(0,selectablePart.length))
        // Combine the non-selectable string with the selectable string
        text.append(selectablePart)
        
        // text.append(NSAttributedString(string: " and "))
        
        
        let selectablePart1 = NSMutableAttributedString(string: "Privacy Policy")
        selectablePart1.addAttribute(NSAttributedString.Key.font, value: textView.font as Any, range: NSMakeRange(0, selectablePart1.length))
        selectablePart1.addAttributes([NSAttributedString.Key.font: textView.font as Any,NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor.green ], range: NSMakeRange(0, selectablePart1.length))
        selectablePart1.addAttribute(NSAttributedString.Key.link, value: "http://www.aboutme360.com/privacy-policy.html", range: NSMakeRange(0,selectablePart1.length))
        // Combine the non-selectable string with the selectable string
        text.append(selectablePart1)
        
        text.append(NSAttributedString(string: ". For Phone Number Verification we will send a OTP via SMS "))
        text.addAttribute(NSAttributedString.Key.font, value: textView.font as Any, range: NSMakeRange(0, text.length))
        text.addAttributes([NSAttributedString.Key.font: textView.font as Any,NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): color.appLightBlueColor ], range: NSMakeRange(0, text.length))
        // Center the text (optional)
        let paragraphStyle = NSMutableParagraphStyle()
        // paragraphStyle.alignment = NSTextAlignment.center
        text.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, text.length))
        
        // To set the link text color (optional)
        textView.linkTextAttributes = [NSAttributedString.Key.foregroundColor:color.appDarkBlueColor, NSAttributedString.Key.font: textView.font as Any]
        // Set the text view to contain the attributed text
        textView.attributedText = text
        // Disable editing, but enable selectable so that the link can be selected
        textView.isEditable = false
        textView.isSelectable = true
        // Set the delegate in order to use textView(_:shouldInteractWithURL:inRange)
        textView.delegate = self
        
    }
    
    // I agree to AboutMe360’s User Agreement and Privacy Policy. For Phone Number Verification we will send a OTP via SMS
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        
        // **Perform sig
        return true
    }
    
    //MARK: - IBAction
    
    @IBAction func verificationButtonTapped(_ sender: Any) {
        
        self.view.endEditing(true)
        self.signupAPI()
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func checkButtonTapped(_ sender: Any) {
        self.checkBoxButton.isSelected = !self.checkBoxButton.isSelected
    }
    
}

extension SignUpViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: OneTextFieldCell.className, for: indexPath) as? OneTextFieldCell {
            cell.selectionStyle = .none
            cell.inputTextField.isSecureTextEntry = false
            cell.imageViewCheck.isHidden = true
            cell.inputTextField.delegate = self
            cell.inputTextField.tag = indexPath.row
            cell.inputTextField.keyboardType = .default
            
            switch indexPath.row {
            case 0:
                cell.inputTextField.placeholder = StringConstants.name
                cell.inputTextField.autocapitalizationType = .words
                cell.textDidChanged = { (cell,text) in
                    self.name = text?.trim()
                    cell.imageViewCheck.isHidden =  self.name?.count == 0 ? true :  false
                }
            case 1:
                cell.inputTextField.placeholder = StringConstants.email
                cell.textDidChanged = { (cell,text) in
                    self.email = text?.trim()
                    cell.imageViewCheck.isHidden =  Utilities.isValidEmailAddress(self.email ?? "") == true ? false :  true
                }
                
            case 2:
                cell.inputTextField.placeholder = StringConstants.mobileNumer
                cell.inputTextField.keyboardType = .phonePad
                cell.inputTextField.addDoneButtonOnKeyboard()
                cell.textDidChanged = { (cell,text) in
                    self.mobileNumber = text?.trim()
                    cell.imageViewCheck.isHidden =  self.mobileNumber?.count == 0 ? true :  false
                }
                
            case 3:
                cell.inputTextField.placeholder = StringConstants.Password
                cell.inputTextField.isSecureTextEntry = true
                cell.imageViewCheck.isHidden = true
                cell.showPasswordButton.isHidden = false
                cell.textDidChanged = { (cell,text) in
                    self.password = text?.trim()
                    //cell.imageViewCheck.isHidden =  self.password?.count == 0 ? true :  false
                }
                cell.showPassword = { (cell) in
                    cell.inputTextField.isSecureTextEntry = !cell.inputTextField.isSecureTextEntry
                }
                
            default:
                print("####")
            }
            return cell
        }
        return UITableViewCell()
    }
    
}


extension SignUpViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text, let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            //self.updateText = updatedText
            switch textField.tag {
            case 0:
                if updatedText.count > Constants.ValidationsLength.firstNameMaxLength {
                    return false
                }
            case 1:
                if updatedText.count>Constants.ValidationsLength.emailMaxLength {
                    return false
                }
            case 2:
                if updatedText.count > Constants.ValidationsLength.mobileNumberMaxLength {
                    return false
                }
            case 3:
                if updatedText.count > Constants.ValidationsLength.passwordNumberMaxLength {
                    return false
                }
            default:
                print("")
            }
        }
        return true
    }
    
}
