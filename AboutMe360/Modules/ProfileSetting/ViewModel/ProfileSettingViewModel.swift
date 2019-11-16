//
//  ProfileSettingViewModel.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 25/09/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

class ProfileSettingViewModel {

    
    // Fetch
    func profileHideAPI(paramDict: [String:String],completion: @escaping (Any?, Bool)-> Void) {
        
        NetworkManager.shared().getRequest(urlString: self.getProfileToggleURL(dict: paramDict), param: nil, authDict: self.getAuthParams(), completionHandler: { (response, success) in
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
    
    private func getProfileToggleURL(dict: [String: String])-> String {
        let url = kBaseURL + APIName.profileToggle.rawValue+dict.queryString
        return url
    }
    
    private func getAuthParams()-> [String: String] {
        var params = [String: String]()
        params[Constants.Keys.kAuthUserName] = Utilities.toString(object: Defaults[.userId])
        params[Constants.Keys.kAuthPassword] = Defaults[.token]
        return params
    }

}
