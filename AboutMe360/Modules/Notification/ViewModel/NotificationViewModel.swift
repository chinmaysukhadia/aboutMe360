//
//  NotificationViewModel.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 02/10/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

class NotificationViewModel {

    // Fetch
    func getNotificationAPI(paramDict: [String:AnyObject],completion: @escaping (Any?, Bool)-> Void) {
        
        NetworkManager.shared().getRequest(urlString: kBaseURL + APIName.notification.rawValue, param: nil, authDict: self.getAuthParams(), completionHandler: { (response, success) in
            if success {
                
                if let safeResponse =  response as? [String: AnyObject] {
                    print(safeResponse)
                    let notificationModel = NotificationModel.formattedDataDict(data: safeResponse)
                    completion(notificationModel,true)
                    return
                }
            }
            
            completion(nil,false)

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
    
    
    // Fetch
    func acceptAPI(paramDict: [String:String],completion: @escaping (Any?, Bool)-> Void) {
        
        NetworkManager.shared().postRequest(urlString: self.getAcceptRL(dict: paramDict), param: nil, authDict: self.getAuthParams(), completionHandler: { (response, success) in
            if success {
                
                if let safeResponse =  response as? [String: AnyObject] {
                    print(safeResponse)
                    let notificationModel = NotificationModel.formattedDataDict(data: safeResponse)
                    completion(notificationModel,true)
                    return
                }
            }
            
            if let safeResponse =  response as? [String: AnyObject], let message = safeResponse[Constants.Keys.kMessage] as? String {
                Utilities.showToast(message: message)
            }
        })
    }
    
    private func getAcceptRL(dict: [String: String])-> String {
        let url = kBaseURL + APIName.acceptRating.rawValue+dict.queryString
        return url
    }
    
    func declineAPI(paramDict: [String:String],completion: @escaping (Any?, Bool)-> Void) {
        
        NetworkManager.shared().getRequest(urlString: self.getDeclineURL(dict: paramDict), param: nil, authDict: self.getAuthParams(), completionHandler: { (response, success) in
            if success {
                
                if let safeResponse =  response as? [String: AnyObject] {
                    print(safeResponse)
                    let notificationModel = NotificationModel.formattedDataDict(data: safeResponse)
                    completion(notificationModel,true)
                    return
                }
            }
            
            if let safeResponse =  response as? [String: AnyObject], let message = safeResponse[Constants.Keys.kMessage] as? String {
                Utilities.showToast(message: message)
            }
        })
    }
    
    private func getDeclineURL(dict: [String: String])-> String {
        let url = kBaseURL + APIName.declineRating.rawValue+dict.queryString
        return url
    }


}
