//
//  FeedbackCommentViewModel.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 02/10/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import Foundation
import SwiftyUserDefaults
import UIKit

class FeedbackCommentViewModel {
    
    //
    func feedbackAPI(param: [String: String],completion: @escaping (Any?, Bool)-> Void) {
        
        NetworkManager.shared().getRequest(urlString: self.getURL(dict: param), param: nil, authDict: self.getProfileAuthParams(), completionHandler: { (response, success) in
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
    
    private func getProfileAuthParams()-> [String: String] {
        var params = [String: String]()
        params[Constants.Keys.kAuthUserName] = Utilities.toString(object: Defaults[.userId])
        params[Constants.Keys.kAuthPassword] = Defaults[.token]
        return params
    }
    
    private func getURL(dict: [String: String])-> String {
        let url = kBaseURL + APIName.feedback.rawValue+dict.queryString
        return url
    }
    
}

