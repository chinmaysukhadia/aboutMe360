//
//  SignUpViewModel.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 23/09/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

class SignUpViewModel {
    
    func validateSignUpFormData(dataDict: [String : String], completion: ((Bool, String)-> Void)?) {
        
        let name = (dataDict[Constants.Keys.kName] ?? "").trim()
        let email = (dataDict[Constants.Keys.kEmail] ?? "").trim()
        
        if name.isEmpty {
            completion?(false,StringConstants.enterFirstName)
            return
        }
        
        if email.isEmpty {
            completion?(false,StringConstants.enterEmailAddress)
            return
        }
        
        if !Utilities.isValidEmailAddress(email) {
            completion?(false,StringConstants.enterAValidEmailAddress)
            return
        }
        
        let mobileNumber = (dataDict[Constants.Keys.kMobileNumer] ?? "").trim()
        let password = (dataDict[Constants.Keys.kPassword] ?? "").trim()
        
        if mobileNumber.isEmpty {
            completion?(false,StringConstants.enterMobileNumber)
            return
        }
        
        if mobileNumber.count < 10  {
            completion?(false,StringConstants.enterValidMobileNumber)
            return
        }
        
        if password.isEmpty {
            completion?(false,StringConstants.enterPassword)
            return
        }
        
        if password.count < 8 {
            completion?(false,StringConstants.passwordShouldBeBetween)
            return
        }
        
        completion?(true, "")
    }
    
    // Fetch
    func signUpAPI(paramDict: [String:String],completion: @escaping (Any?, Bool)-> Void) {
        
        NetworkManager.shared().getRequest(urlString: kBaseURL + APIName.signup.rawValue, param: getParamDict(dict: paramDict), authDict: self.getAuthParams(paramDict), completionHandler: { (response, success) in
            if success {
                
                if response is [String: AnyObject] {
                    
                    completion(nil,true)
                   // return
                }
            }
            
            if let safeResponse =  response as? [String: AnyObject], let message = safeResponse[Constants.Keys.kMessage] as? String {
                Utilities.showToast(message: message)
            }
        })
    }
    
    private func getParamDict(dict: [String: String])-> [String: AnyObject] {
        var params = [String: AnyObject]()
        params[Constants.Keys.kName] = dict[Constants.Keys.kName]?.trim() as AnyObject?
        params[Constants.Keys.kEmail] = dict[Constants.Keys.kEmail]?.trim() as AnyObject?
        params[Constants.Keys.kFcm_token] = Defaults[.deviceToken] as AnyObject?
        Defaults[.name] = dict[Constants.Keys.kName]?.trim()
        return params
    }
    
    private func getAuthParams(_ dataDict: [String: String]?)-> [String: String] {
        var params = [String: String]()
        params[Constants.Keys.kAuthUserName] = dataDict?[Constants.Keys.kMobileNumer]?.trim()
        params[Constants.Keys.kAuthPassword] = dataDict?[Constants.Keys.kPassword]?.trim()
        return params
    }
}
