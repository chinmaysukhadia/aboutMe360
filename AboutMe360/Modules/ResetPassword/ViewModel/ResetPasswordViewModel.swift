//
//  ResetPasswordViewModel.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 23/09/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

class ResetPasswordViewModel {
    
    func validateNewPasswordFormData(dataDict: [String : String], completion: ((Bool, String)-> Void)?) {
        
        let mobileNumer = (dataDict[Constants.Keys.kPassword] ?? "").trim()
        
        if mobileNumer.isEmpty {
            completion?(false,StringConstants.enterPassword)
            return
        }
        completion?(true, "")
    }
    
    // Fetch
    func resetAPI(paramDict: [String:String], authDict:[String:String],completion: @escaping (Any?, Bool)-> Void) {
        
        NetworkManager.shared().getRequest(urlString: kBaseURL + APIName.setNewPassword.rawValue, param: paramDict as [String : AnyObject], authDict: self.getAuthParams(authDict), completionHandler: { (response, success) in
            if success {
                
                if response is [String: AnyObject] {
                    
                    completion(nil,true)
                }
            }
            
            if let safeResponse =  response as? [String: AnyObject], let message = safeResponse[Constants.Keys.kMessage] as? String {
                Utilities.showToast(message: message)
            }
        })
    }
    
    private func getAuthParams(_ dataDict: [String: String]?)-> [String: String] {
        var params = [String: String]()
        params[Constants.Keys.kAuthUserName] = dataDict?[Constants.Keys.kOtp]?.trim()
        params[Constants.Keys.kAuthPassword] = dataDict?[Constants.Keys.kPassword]?.trim()
        return params
    }
}
