//
//  LandingViewController.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 02/10/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class LandingViewController: BaseViewController,UITextViewDelegate {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.setUp()
    }
    
    //MARK: - Private Methods
    
    private func setUp() {
        
        self.contentView.roundCorners(12.0)
        self.loginButton.roundCorners(4.0)
        
        let text = NSMutableAttributedString(string: "aboutME360 is a rating app that provides 360 degree appraisal of an individual/professional, done by his/her Supervisors, Peers/Stakehold-ers, Subordinates, Acquaintances in their indi-vidual capacity, across 20 critical traits. To assist interviewers, select required skill set. ")
        text.addAttributes([NSAttributedString.Key.font: UIFont(name: "Nunito-SemiBold", size: 16) as Any,NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor.white], range: NSMakeRange(0, text.length))

        let selectablePart = NSMutableAttributedString(string: "More...")
        selectablePart.addAttributes([NSAttributedString.Key.font: UIFont(name: "Nunito-Bold", size: 16) as Any,.underlineStyle: NSUnderlineStyle.single.rawValue,NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor.white], range: NSMakeRange(0, selectablePart.length))
        selectablePart.addAttribute(NSAttributedString.Key.link, value: "https://aboutme360.com", range: NSMakeRange(0,selectablePart.length))
        text.append(selectablePart)
        
        let paragraphStyle = NSMutableParagraphStyle()
        // paragraphStyle.alignment = NSTextAlignment.center
        text.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, text.length))
        
        // To set the link text color (optional)
        textView.linkTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white, NSAttributedString.Key.font: textView.font as Any]
        // Set the text view to contain the attributed text
        textView.attributedText = text
        // Disable editing, but enable selectable so that the link can be selected
        textView.isEditable = false
        textView.isSelectable = true
        // Set the delegate in order to use textView(_:shouldInteractWithURL:inRange)
        textView.delegate = self
        
        if Defaults[.isProfileCreated] != nil {
            
            Threads.performTaskInMainQueue {
                guard let profilePictureViewC = DIConfigurator.profilePictureViewController() as? ProfilePictureViewController  else {
                    return
                }
                self.navigationController?.pushViewController(profilePictureViewC, animated: true)
            }
        }
        
                
    }
    
    // I agree to AboutMe360’s User Agreement and Privacy Policy. For Phone Number Verification we will send a OTP via SMS
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        
        // **Perform sig
        return true
    }
    
    //MARK: - IBAction
    
    @IBAction func continueTologinTapped(_ sender: Any) {
        
//        guard let verificationVC = DIConfigurator.verificationViewController() as? VerificationViewController  else {
//            return
//        }
//        verificationVC.verificationType = .signUp
//        verificationVC.mobileNumber = "632754736254"
//        self.navigationController?.pushViewController(verificationVC, animated: true)
        
        
        guard let loginVC =  DIConfigurator.loginViewController() else { return  }
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
}

extension NSMutableAttributedString {
    
    public func setAsLink(textToFind:String, linkURL:String) -> Bool {
        
        let foundRange = self.mutableString.range(of: textToFind)
        if foundRange.location != NSNotFound {
            self.addAttribute(NSAttributedString.Key.link, value: linkURL, range: foundRange)
            return true
        }
        return false
    }
}
