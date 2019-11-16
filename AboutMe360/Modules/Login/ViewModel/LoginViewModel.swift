//
//  LoginViewModel.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 9/22/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

class LoginViewModel {
    
    func validateLoginFormData(loginDataDict: [String : String], completion: ((Bool, String)-> Void)?) {
        
        let mobileNumber = (loginDataDict[Constants.Keys.kMobileNumer] ?? "").trim()
        let password = (loginDataDict[Constants.Keys.kPassword] ?? "").trim()
        
        if mobileNumber.isEmpty {
            completion?(false,StringConstants.enterMobileNumber)
            return
        }
        
        if mobileNumber.count < 10  {
            completion?(false,StringConstants.enterValidMobileNumber)
                   return
        }
        
        if password.isEmpty {
            completion?(false, StringConstants.enterPassword)
            return
        }
        completion?(true, "")
    }
    
    // Fetch login data
    func loginAPI(authDict: [String:String]?,completion: @escaping (Any?, Bool)-> Void) {
        
        NetworkManager.shared().getRequest(urlString: self.getLoginURL(), param: [Constants.Keys.kFcm_token: Defaults[.deviceToken] as AnyObject], authDict: self.getAuthParams(authDict), completionHandler: { (response, success) in
          
            if success {
                if let safeResponse =  response as? [String: AnyObject] {
                    Defaults[.token] = Utilities.toString(object: safeResponse[Constants.Keys.kToken])
                    Defaults[.userId] = Utilities.toInt(safeResponse[Constants.Keys.kUserID])
                    completion(nil,true)
                    return
                }
            }
            
            if let safeResponse =  response as? [String: AnyObject], let message = safeResponse[Constants.Keys.kMessage] as? String {
                Utilities.showToast(message: message)
            }
        })
    }
    
    private func getLoginURL()-> String {
        var params = [String: String]()
        params[Constants.Keys.kFcm_token] = Defaults[.deviceToken]
        let url = kBaseURL + APIName.signin.rawValue+params.queryString
        return url
    }
    
    private func getAuthParams(_ dataDict: [String: String]?)-> [String: String] {
        var params = [String: String]()
        params[Constants.Keys.kAuthUserName] = dataDict?[Constants.Keys.kMobileNumer]?.trim()
        params[Constants.Keys.kAuthPassword] = dataDict?[Constants.Keys.kPassword]?.trim()
        return params
    }
    
    // Fetch Profile data
    func profileAPI(authDict: [String:String]?,param: [String: AnyObject]?,completion: @escaping (Any?, Bool)-> Void) {
        
        NetworkManager.shared().getRequest(urlString: kBaseURL + APIName.readProfile.rawValue, param: param, authDict: self.getProfileAuthParams(), completionHandler: { (response, success) in
            if success {
                
                if let safeResponse =  response as? [String: AnyObject] {
                    print(safeResponse)
                    let homeModel = HomeModel.formattedDataDict(data: safeResponse)
                    //Defaults[.profleData] = homeModel
                    Defaults[.isLogin] = true
                    completion(homeModel,true)
                    return
                }
            }
            
            if let safeResponse =  response as? [String: AnyObject], let message = safeResponse[Constants.Keys.kMessage] as? String {
                Utilities.showToast(message: message)
            }
        })
    }
    //[Constants.Keys.kUserID: "" as AnyObject]
    private func getProfileAuthParams()-> [String: String] {
        var params = [String: String]()
        params[Constants.Keys.kAuthUserName] = Utilities.toString(object: Defaults[.userId])
        params[Constants.Keys.kAuthPassword] = Defaults[.token]
        return params
    }
}
