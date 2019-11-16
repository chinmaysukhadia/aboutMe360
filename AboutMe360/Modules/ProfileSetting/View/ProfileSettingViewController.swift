//
//  ProfileSettingViewController.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 16/09/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class ProfileSettingViewController: BaseViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var switchonOff: UISwitch!
    @IBOutlet weak var decativeDescLabel: UILabel!
    
    //MARK: - Variables
    
    var profileSettingViewModel: ProfileSettingViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.setUp()
    }
    
    //MARK: - Private Methods
    
    private func setUp() {
        self.setUpViewModel()
     //   "Post deactivation, profile and current rating will stay on the app with annotation 'Account is deactivated'. You can reactivate your account by logging in."
        
        
       // let fontName = self.decativeDescLabel.font.fontName
        let  fontSize = self.decativeDescLabel.font.pointSize

        let text = NSMutableAttributedString(string: "Post deactivation, profile and current rating will stay on the app with annotation '")
        let selectablePart = NSMutableAttributedString(string: "Account is deactivated")
       // selectablePart.addAttribute(NSAttributedString.Key.font, value: decativeDescLabel.font as Any, range: NSMakeRange(0, selectablePart.length))
        selectablePart.addAttributes([NSAttributedString.Key.font: UIFont(name: "Nunito-SemiBold", size: fontSize) as Any,NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor.black], range: NSMakeRange(0, selectablePart.length))
        text.append(selectablePart)
        text.append(NSAttributedString(string: "'. You can reactivate your account by logging in."))
        
        decativeDescLabel.attributedText = text
    }
    
    // Model Initialization
    private func setUpViewModel() {
        profileSettingViewModel = ProfileSettingViewModel()
        if let profileStatus = Defaults[.profleData]?.homeData?.profileType {
            switchonOff.isOn = Utilities.toInt(profileStatus) == 0 ? false : true
        }
    }
    
    //MARK: - IBAction
    
    @IBAction func profileHideButtonTapped(_ sender: UISwitch) {
        
        if sender.isOn == false {
            
            Alert.showAlertWithActionWithColor(title: "Change your account to public?", message: "Anyone will be able to rate your profile. You no longer will need to approve ratings.", actionTitle: "Confirm", showCancel: true) { (action) in
                
                if action == 1 {
                    self.profileSettingViewModel?.profileHideAPI(paramDict: [Constants.Keys.kPtoggleValue: Utilities.toString(object: sender.isOn)],completion: { (_, success) in
                        if success {
                            self.profileData()
                        }
                    })
                } else {
                    self.switchonOff.isOn = !self.switchonOff.isOn
                }
            }
        } else {
            self.profileSettingViewModel?.profileHideAPI(paramDict: [Constants.Keys.kPtoggleValue: Utilities.toString(object: sender.isOn)],completion: { (_, success) in
                
                if success {
                    self.profileData()
                }
            })
        }
        
    }
    
    func profileData() {
                                let loginViewModel = LoginViewModel()
        loginViewModel.profileAPI(authDict: nil, param: [Constants.Keys.kUserID: "" as AnyObject],completion: { (data, success) in
            
            if success {
                Defaults[.profleData] = data as? HomeModel
            }
        })
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func deactivateTapped(_ sender: Any) {
        guard let deactivationAccountVC = DIConfigurator.deactivationAccountViewController() as? DeactivationAccountViewController  else {
            return
        }
        self.navigationController?.pushViewController(deactivationAccountVC, animated: true)
    }
    
    @IBAction func termAndConditionTapped(_ sender: Any) {
        guard let helpVC = DIConfigurator.helpViewController() as? HelpViewController  else {
            return
        }
        helpVC.webContentType = .termAndCondition
        self.navigationController?.pushViewController(helpVC, animated: true)
    }
    
    @IBAction func needHelpTapped(_ sender: Any) {
        guard let helpVC = DIConfigurator.helpViewController() as? HelpViewController  else {
            return
        }
        helpVC.webContentType = .help
        self.navigationController?.pushViewController(helpVC, animated: true)
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
   
        Alert.showAlertWithActionWithColor(title: "Log Out", message: "Are you sure you want to Log Out?", actionTitle: "Log Out", showCancel: true) { (action) in
            
            if action == 1 {
                AppDelegate.delegate()?.showLogin()
            }
        }
    }
    
}
