//
//  EditProfileViewModel.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 25/09/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

class EditProfileViewModel {
    
    func validateEditProfileFormData(dataDict: [String : String], completion: ((Bool, String)-> Void)?) {
        
        let name = (dataDict[Constants.Keys.kFullName] ?? "").trim()
        let email = (dataDict[Constants.Keys.kEmail] ?? "").trim()
        let mobileNumber = (dataDict[Constants.Keys.kMobileNumer] ?? "").trim()

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
        
        if mobileNumber.isEmpty {
            completion?(false,StringConstants.enterMobileNumber)
            return
        }
        
        if mobileNumber.count < 10  {
            completion?(false,StringConstants.enterValidMobileNumber)
                   return
        }
        
        completion?(true, "")
    }
    
    
    //
    func updateProfileAPI(paramDict: [String:String],completion: @escaping (Any?, Bool)-> Void) {
        
        NetworkManager.shared().postRequest(urlString: self.getURL(dict: paramDict), param: self.getProfileParam(dict: paramDict), authDict: self.getAuthParams(), completionHandler: { (response, success) in
            if success {
                
                if response is [String: AnyObject] {
                    
                    completion(nil,true)
                     return
                }
            }
            
            if let safeResponse =  response as? [String: AnyObject], let message = safeResponse[Constants.Keys.kMessage] as? String {
                Utilities.showToast(message: message)
            }
        })
        
    }
    
    private func getProfileParam(dict : [String: String])-> [String: String] {
        var params = [String: String]()
        params[Constants.Keys.kProfileImg] = dict[Constants.Keys.kProfileImg]?.trim()
        return params
    }
    
    private func getURL(dict: [String: String])-> String {
        var params = [String: String]()
        params[Constants.Keys.kFullName] = dict[Constants.Keys.kFullName]?.trim()
        params[Constants.Keys.kEmail] = dict[Constants.Keys.kEmail]?.trim()
        params[Constants.Keys.kMobileNumer] = dict[Constants.Keys.kMobileNumer]?.trim()
        params[Constants.Keys.kdob] = dict[Constants.Keys.kdob]?.trim()
        let url = kBaseURL + APIName.updateProfile.rawValue+params.queryString
        
        return url
    }
    
    private func getAuthParams()-> [String: String] {
        var params = [String: String]()
        params[Constants.Keys.kAuthUserName] = Utilities.toString(object: Defaults[.userId])
        params[Constants.Keys.kAuthPassword] = Defaults[.token]
        return params
    }
    
    func verifyUpdateProfileOTPAPI(paramDict: [String:String],completion: @escaping (Any?, Bool)-> Void) {
        
        NetworkManager.shared().getRequest(urlString: self.getUpdateProfileParamDict(dict: paramDict), param: nil, authDict: self.getUpdateProfileAuthParams(), completionHandler: { (response, success) in
            if success {
                
                if let responseDict = response as? [String: AnyObject] {
                    completion(responseDict[Constants.Keys.kOtp],true)
                    return
                }
            }
            
            if let safeResponse =  response as? [String: AnyObject], let message = safeResponse[Constants.Keys.kMessage] as? String {
                Utilities.showToast(message: message)
            }
        })
    }
    
    private func getUpdateProfileParamDict(dict: [String: String])-> String {
        var params = [String: String]()
        params[Constants.Keys.kMobileNumer] = dict[Constants.Keys.kMobileNumer]?.trim()
        let url = kBaseURL + APIName.updateOtp.rawValue+params.queryString
        return url
    }
    
    private func getUpdateProfileAuthParams()-> [String: String] {
        var params = [String: String]()
        params[Constants.Keys.kAuthUserName] = Utilities.toString(object: Defaults[.userId])
        params[Constants.Keys.kAuthPassword] = Defaults[.token]
        return params
    }
}
