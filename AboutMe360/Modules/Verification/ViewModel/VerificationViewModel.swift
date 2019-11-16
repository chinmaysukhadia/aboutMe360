//
//  VerificationViewModel.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 23/09/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

class VerificationViewModel {

    // Fetch
    func verifyForgotPasswordAPI(paramDict: [String:String],completion: @escaping (Any?, Bool)-> Void) {
        
        NetworkManager.shared().getRequest(urlString: self.getVerifyForgotPasswordUrl(dict: paramDict), param: nil, authDict: nil, completionHandler: { (response, success) in
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
    
    private func getVerifyForgotPasswordUrl(dict: [String: String])-> String {
        let url = kBaseURL + APIName.verifyForgotPass.rawValue+dict.queryString
        return url
    }

    
    func verifySignOtpAPI(paramDict: [String:String],completion: @escaping (Any?, Bool)-> Void) {
        
        NetworkManager.shared().postRequest(urlString: self.getParamDict(dict: paramDict), param: nil, authDict: self.getAuthParams(paramDict), completionHandler: { (response, success) in
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
    
    private func getParamDict(dict: [String: String])-> String {
        var params = [String: String]()
        params[Constants.Keys.kName] = dict[Constants.Keys.kName]?.trim()
        params[Constants.Keys.kEmail] = dict[Constants.Keys.kEmail]?.trim()
        params[Constants.Keys.kFcm_token] = Defaults[.deviceToken]
        params[Constants.Keys.kMobileNumer] = dict[Constants.Keys.kMobileNumer]?.trim()
        let url = kBaseURL + APIName.verifySignUp.rawValue+params.queryString

        return url
    }
    
    private func getAuthParams(_ dataDict: [String: String]?)-> [String: String] {
        var params = [String: String]()
        params[Constants.Keys.kAuthUserName] = dataDict?[Constants.Keys.kOtp]?.trim()
        params[Constants.Keys.kAuthPassword] = dataDict?[Constants.Keys.kPassword]?.trim()
        return params
    }
    

}
