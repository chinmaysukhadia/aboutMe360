//
//  DeactivationAccountViewModel.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 25/09/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

class DeactivationAccountViewModel {
    
    func validateDeactivateFormData(dataDict: [String : String], completion: ((Bool, String)-> Void)?) {
        
        let name = (dataDict[Constants.Keys.kIssue] ?? "").trim()
        
        if name.isEmpty {
            completion?(false,StringConstants.PleaseSelectResaon)
            return
        }
        
        completion?(true, "")
    }
    
    //
    func deactivateAPI(paramDict: [String:AnyObject],completion: @escaping (Any?, Bool)-> Void) {
        
        NetworkManager.shared().getRequest(urlString: kBaseURL + APIName.deactivateAccount.rawValue, param: paramDict, authDict: self.getAuthParams(), completionHandler: { (response, success) in
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
    
    private func getAuthParams()-> [String: String] {
        var params = [String: String]()
        params[Constants.Keys.kAuthUserName] = Utilities.toString(object: Defaults[.userId])
        params[Constants.Keys.kAuthPassword] = Defaults[.token]
        return params
    }
}

