//
//  EditHeighestQualificationViewModel.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 26/09/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

class EditHeighestQualificationViewModel {

    func validateFormData(dataDict: [String : String], completion: ((Bool, String)-> Void)?) {
        
        let designation = Utilities.toString(object: dataDict[Constants.Keys.kHighQualification]).trim()
        
        if designation.isEmpty {
            completion?(false,StringConstants.enterHighQualification)
            return
        }
        
        completion?(true,"")
    }
    
    // Fetch
    func updateHeighestQualificationAPI(paramDict: [String:String],completion: @escaping (Any?, Bool)-> Void) {
        
        NetworkManager.shared().getRequest(urlString: self.getURL(dict: paramDict), param: nil, authDict: self.getAuthParams(), completionHandler: { (response, success) in
            
            print(response)
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

    private func getURL(dict: [String: String])-> String {
        let url = kBaseURL + APIName.editHqualification.rawValue+dict.queryString
        return url
    }
    
    private func getAuthParams()-> [String: String] {
        var params = [String: String]()
        params[Constants.Keys.kAuthUserName] = Utilities.toString(object: Defaults[.userId])
        params[Constants.Keys.kAuthPassword] = Defaults[.token]
        return params
    }
}
