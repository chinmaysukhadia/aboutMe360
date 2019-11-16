//
//  ForgotPasswordViewModel.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 23/09/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

class ForgotPasswordViewModel {
    
    func validateForgotPasswordFormData(dataDict: [String : String], completion: ((Bool, String)-> Void)?) {
        
        let mobileNumber = (dataDict[Constants.Keys.kMobileNumer] ?? "").trim()
        
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
    
    // Fetch
    func forgotPasswordAPI(paramDict: [String:String],completion: @escaping (Any?, Bool)-> Void) {
        
        NetworkManager.shared().getRequest(urlString: kBaseURL + APIName.forgotPassword.rawValue, param: paramDict as [String : AnyObject], authDict: nil, completionHandler: { (response, success) in
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
    

}
