//
//  NetworkManager.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 9/22/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import Foundation
import Alamofire
import SVProgressHUD
class NetworkManager {
    
    private static var sharedNetworkManager: NetworkManager = {
        let networkManager = NetworkManager()
        return networkManager
    }()
    
    class func shared() -> NetworkManager {
        return sharedNetworkManager
    }
    
    //MARK: - Request
    func getRequest(urlString: String,param : [String: AnyObject]?,authDict: [String:String]?,_ showLoader: Bool = true , completionHandler: @escaping (_ responseData: Any, _ success: Bool) -> Void) {
        
        print("urlString")
        print(urlString)
        
        var headers:HTTPHeaders?
        if let dict = authDict, dict.count > 0 {
            let userName = Utilities.toString(object: dict[Constants.Keys.kAuthUserName])
            let password = Utilities.toString(object:dict[Constants.Keys.kAuthPassword])
            let credentialData = "\(userName ):\(password )".data(using: .utf8)
            let base64Credentials = credentialData?.base64EncodedString(options: [])
            headers = ["Authorization": "Basic \(base64Credentials ?? "")"]
            print(userName)
            print(password)
        }
        
        print("param")
        print(param as Any)
        let escapedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

        if showLoader {
            Utilities.showLoader()
        }
        
        Alamofire.request(escapedString ?? "", method: .get,parameters: param, encoding: URLEncoding.default,headers:headers).responseString { (responseObject) -> Void in
            
            Utilities.hideLoader()
           // responseJSON

            switch (responseObject.result) {
            case .success( _):
                
                print("response")
                print(responseObject.result.value as Any)
                
                if let safeResponse =  responseObject.result.value {
                    let dict = self.convertToDictionary(text: safeResponse)
                    //                    print(safeResponse)
                    let status = Utilities.toInt(dict?[Constants.Keys.kStatus])
                    if status == kSuccessStatus {
                        completionHandler(dict as Any,true)
                        return
                    }
                    completionHandler(dict as Any,false)
                } else {
                    Utilities.showToast(message: StringConstants.something)
                }
                return
            case .failure( _):
                Utilities.showToast(message: StringConstants.something)
                return
            }
        
        }
    }
    
    //MARK: - Request
    func postRequest(urlString: String,param : [String: String]?,authDict: [String:String]?, completionHandler: @escaping (_ responseData: Any, _ success: Bool) -> Void) {
        
        print("urlString")
        print(urlString)
        let escapedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

        var headers:HTTPHeaders?
        if let dict = authDict, dict.count > 0 {
            let userName = Utilities.toString(object: dict[Constants.Keys.kAuthUserName])
            let password = Utilities.toString(object:dict[Constants.Keys.kAuthPassword])
            
            let credentialData = "\(userName ):\(password )".data(using: .utf8)
            let base64Credentials = credentialData?.base64EncodedString(options: [])
            headers = ["Authorization": "Basic \(base64Credentials ?? "")","Content-Type": "application/x-www-form-urlencoded"]
            print(headers as Any)

        }
        
        
        print("param")
        print(param as Any)
        
        Utilities.showLoader()

        Alamofire.request(escapedString ?? "", method: .post,parameters: param, encoding: URLEncoding.default,headers:headers).responseString { (responseObject) -> Void in
            //responseString
            Utilities.hideLoader()
            print(responseObject.result.value as Any)

            switch (responseObject.result) {
            case .success( _):
                
                if let safeResponse =  responseObject.result.value {
                    let dict = self.convertToDictionary(text: safeResponse)
//                    print(safeResponse)
                    let status = Utilities.toInt(dict?[Constants.Keys.kStatus])
                    if status == kSuccessStatus {
                        completionHandler(dict as Any,true)
                        return
                    }
                    completionHandler(dict as Any,false)
                }else {
                    Utilities.showToast(message: StringConstants.something)
                }
            case .failure( _):
                
                Utilities.showToast(message: StringConstants.something)
                break
            }
            
            
        }
    }
    
    func convertToDictionary(text: String) -> [String: AnyObject]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
}
