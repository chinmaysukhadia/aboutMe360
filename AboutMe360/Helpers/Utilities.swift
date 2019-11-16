//
//  Utilities.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 15/09/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import Foundation
import UIKit
import SystemConfiguration
import AVFoundation
import MobileCoreServices
import Toaster
import SVProgressHUD

class Utilities {
    
    class func topMostViewController() -> UIViewController {
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return UIViewController()
    }
    
    class func getScaleFactor() -> CGFloat {
        let screenRect:CGRect = UIScreen.main.bounds
        let screenWidth:CGFloat = screenRect.size.width
        let scalefactor:CGFloat = (screenWidth / 375.0)
        return scalefactor
    }
    
    class var isRTLMode: Bool {
        // Arabic layout
        return UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft
    }
    
    class func getTopMostViewController() -> UIViewController {
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return UIViewController()
    }
    
    class func isInternetAvailable() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }
        
    
    // MARK: - Email Validations
    
    class func isValidEmailAddress(_ testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    // MARK: - Password Validations
    class func isValidPasssword(_ password: String) -> Bool {
        /*
         Minimum 8 characters at least 1 Alphabet and 1 Number:
         
         "^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$"
         Minimum 8 characters at least 1 Alphabet, 1 Number and 1 Special Character:
         
         "^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,}$"
         Minimum 8 characters at least 1 Uppercase Alphabet, 1 Lowercase Alphabet and 1 Number:
         
         "^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$"
         Minimum 8 characters at least 1 Uppercase Alphabet, 1 Lowercase Alphabet, 1 Number and 1 Special Character:
         
         "^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[d$@$!%*?&#])[A-Za-z\dd$@$!%*?&#]{8,}"
         Minimum 8 and Maximum 10 characters at least 1 Uppercase Alphabet, 1 Lowercase Alphabet, 1 Number and 1 Special Character:
         
         "^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[$@$!%*?&#])[A-Za-z\d$@$!%*?&#]{8,10}"
         */
        
        //        let passwordRegEx = "^(?=.*[a-zA-Z])(?=.*[0-9]).{8,16}"
        
        let passwordRegEx = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$"
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: password)
    }
    
    // MARK: - Username Validations
    class func isValidUsername(_ username: String) -> Bool {
        let regularExpressionText = "^[a-zA-Z0-9_.]+"
        let regularExpression = NSPredicate(format:"SELF MATCHES %@", regularExpressionText)
        return regularExpression.evaluate(with: username)
    }
    
    // MARK: - Phone Number Validations
    //    class func isValidPhoneNumber(_ phone: String, code: String) -> Bool {
    //        let phoneUtil = NBPhoneNumberUtil()
    //        do {
    //            let phoneNumber: NBPhoneNumber = try phoneUtil.parse(phone, defaultRegion: "")
    //            if phoneUtil.isValidNumber(phoneNumber){
    //                return true
    //            } else {
    //                return false
    //            }
    //        } catch let error as NSError {
    //            print(error.localizedDescription)
    //            return false
    //        }
    //    }
    
    class func isValidateAlphabet(_ checkString: NSString) -> Bool {
        let numcharacters: CharacterSet = CharacterSet(charactersIn: " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
        var characterCount: Int32 = 0
        for i in 0 ..< checkString.length {
            let character: unichar = checkString.character(at: i)
            if !numcharacters.contains(UnicodeScalar(character)!) {
                characterCount += 1
            }
        }
        if characterCount == 0 {
            return true
        } else {
            return false
        }
    }
    
    class func isValidateAlphabetWithWhiteSpace(_ checkString: NSString) -> Bool {
        let numcharacters: CharacterSet = CharacterSet(charactersIn: " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ ")
        var characterCount: Int32 = 0
        for i in 0 ..< checkString.length {
            let character: unichar = checkString.character(at: i)
            if !numcharacters.contains(UnicodeScalar(character)!) {
                characterCount += 1
            }
        }
        if characterCount == 0 {
            return true
        } else {
            return false
        }
    }
    
    class func isValidStringNumericPlus(_ checkString: NSString) -> Bool {
        let numcharacters: CharacterSet = CharacterSet(charactersIn: "0123456789+")
        var characterCount: Int32 = 0
        for i in 0 ..< checkString.length {
            let character: unichar = checkString.character(at: i)
            if !numcharacters.contains(UnicodeScalar(character)!) {
                characterCount += 1
            }
        }
        if characterCount == 0 {
            return true
        } else {
            return false
        }
    }
    
    // MARK: - Url Validation
    
    class func isValidUrl(_ urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = NSURL(string: urlString) {
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
    
    class func openUrlInSafari(using urlString: String) {
        var validUrl = urlString
        if !urlString.isEmpty {
            if !(urlString.hasPrefix("http://") || urlString.hasPrefix("https://")) {
                validUrl = "https://" + validUrl
            }
        }
        guard let url = URL(string: validUrl) else { return }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    class func postNotificationObserver(name: Notification.Name) {
        NotificationCenter.default.post(name: name, object: nil)
    }
    
    class func getUDIDString()-> String {
        return UUID().uuidString
    }
   
}

// MARK: - Toaster

extension Utilities {
    
    class func showToast(message: String?) {
        guard let message = message, !message.isEmpty else {
            return
        }
        DispatchQueue.main.async {
            ToastCenter.default.cancelAll()
            Toast(text: message, duration: Delay.short).show()
        }
    }
    
    class func toString(object:Any?) -> String {
        if let str = object as? String {
            return String(format: "%@", str)
        }
        if let num = object as? NSNumber {
            return String(format: "%@", num)
        }
        return ""
    }
    
    class func twoDecimalString(object:Any?) -> String {
        if let str = object as? NSObject {
            return String(format: "%.2f", str)
        }
        return ""
    }
    
    class func toInt(_ object:Any?) -> Int {
        if let obj = object as? NSObject {
            let string = String(format: "%@", obj)
            return Int(string) ?? 0
        }
        return 0
    }
    
    class func toBool(_ object:Any?) -> Bool {
        if let obj = object as? NSObject {
            let string = String(format: "%@", obj)
            return Bool(string) ?? false
        }
        return false
    }
    
    class func toDouble(_ object:Any?) -> Double {
        if let obj = object as? NSObject {
            let string = String(format: "%@", obj)
            return Double(string) ?? 0.0
        }
        return 0.0
    }
    
}

extension Date {
    
    public func dateStringWith(strFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = Calendar.current.timeZone
        dateFormatter.locale = Calendar.current.locale
        dateFormatter.dateFormat = strFormat
        return dateFormatter.string(from: self)
    }
    
}

extension Utilities {
    
    class func showLoader() {
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show()
    }
    
    class func hideLoader() {
        SVProgressHUD.dismiss()
    }
}

public enum ImageFormat {
    case png
    case jpeg(CGFloat)
}

extension UIImage {
    
    public func toBase64(format: ImageFormat) -> String? {
        var imageData: Data?
        
        switch format {
        case .png:
            imageData = self.pngData()
        case .jpeg(let compression):
            imageData = self.jpegData(compressionQuality: compression)
        }
        
        return imageData?.base64EncodedString()
    }
}

