//
//  ProfileViewModel.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 23/09/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

class ProfileViewModel {
    
    func validateProfileFormData(dataDict: [String : String], completion: ((Bool, String)-> Void)?) {
        
        let designation = Utilities.toString(object: dataDict[Constants.Keys.kDesignation]).trim()
        let orgName = Utilities.toString(object: dataDict[Constants.Keys.kOrgName]).trim()
        let industry = Utilities.toString(object: dataDict[Constants.Keys.kIndustry]).trim()
        let jobProfile = Utilities.toString(object: dataDict[Constants.Keys.kJobProfile]).trim()
        let workLocation = Utilities.toString(object: dataDict[Constants.Keys.kWorkLocation]).trim()
        let startDate = Utilities.toString(object: dataDict[Constants.Keys.kDuration]).trim()
        
        if designation.isEmpty {
            completion?(false,StringConstants.enterDesignation)
            return
        }
        
        if orgName.isEmpty {
            completion?(false,StringConstants.enterOrganizationName)
            return
        }
        
        if industry.isEmpty {
            completion?(false,StringConstants.selectIndustry)
            return
        }
        
        if jobProfile.isEmpty {
            completion?(false,StringConstants.selectJobProfile)
            return
        }
        
        if workLocation.isEmpty {
            completion?(false,StringConstants.enterWorkLocation)
            return
        }
        
        if startDate.isEmpty {
            completion?(false,StringConstants.enterStartDate)
            return
        }
        
        completion?(true, "")
    }
    
     func getIndustryDataSource()-> [String]{
    
        return ["Banking/ NBFC Financial","Financial/ Non-Banking","FMCG","IT","Import/ Export Industry","Trading/ Retailing","Manufacturing","Professionals","Student","Others"]
     }
    
    func getProfileDataSource()-> [String]{
        
        return ["Sales","Operations","Finance Department","Risk/ Credit","Legal & Compliance","Analyst/ MIS", "Purchase","Strategy","Audit","Product Development", "Software Development","Artificial Intelligence","Chartered Accountant","Doctor","Lowyer","Architect/Iinterior","Professor/Lecturer/Teacher","Entrepreneur/Self/Employed","Others"]
    }
    
    func getLocationDataSource()-> [String]{
        
        return ["Andhra Pradesh","Andaman and Nicobar Islands","Arunachal Pradesh","Assam","Bihar","Chattisgarh", "Chandigarh", "Dadra and Nagar Haveli","Daman and Diu","Delhi", "Goa","Gujarat","Haryana", "Himachal Pradesh", "Jammu and Kashmir", "Jammu and Kashmir", "Karnataka", "Kerala","Lakshadweep","Madhya Pradesh","Maharashtra","Manipur","Meghalaya","Mizoram","Nagaland","Odisha","Puducherry","Punjab","Rajasthan","Sikkim","Tamil Nadu","Telangana","Tripura","Uttar Pradesh","Uttarakhand","West Bengal"]
    }
    
    // Fetch
    func createAPI(paramDict: [String:String],completion: @escaping (Any?, Bool)-> Void) {
        
        NetworkManager.shared().postRequest(urlString: self.getURL(dict: paramDict), param: self.getProfileParam(dict:paramDict ), authDict: self.getAuthParams(), completionHandler: { (response, success) in
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
    
    private func getProfileParam(dict : [String: String])-> [String: String] {
        var params = [String: String]()
        params[Constants.Keys.kProfileImg] = dict[Constants.Keys.kProfileImg]?.trim()
        return params
    }
    
    private func getURL(dict: [String: String])-> String {
        var params = [String: String]()
        params[Constants.Keys.kdob] = dict[Constants.Keys.kdob]?.trim()
        params[Constants.Keys.kFullName] = dict[Constants.Keys.kFullName]?.trim()
        params[Constants.Keys.kHighQualification] = dict[Constants.Keys.kHighQualification]?.trim()
        params[Constants.Keys.kIndustry] = dict[Constants.Keys.kIndustry]?.trim()
        params[Constants.Keys.kJobProfile] = dict[Constants.Keys.kJobProfile]?.trim()
        params[Constants.Keys.kWorkLocation] = dict[Constants.Keys.kWorkLocation]?.trim()
        params[Constants.Keys.kCurrentlyWorking] = dict[Constants.Keys.kCurrentlyWorking]?.trim()
        params[Constants.Keys.kOrgName] = dict[Constants.Keys.kOrgName]?.trim()
        params[Constants.Keys.kDesignation] = dict[Constants.Keys.kDesignation]?.trim()
        params[Constants.Keys.kDuration] = dict[Constants.Keys.kDuration]?.trim()
        let url = kBaseURL + APIName.createProfile.rawValue+params.queryString
//        let escapedString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        return url
    }
    
    private func getAuthParams()-> [String: String] {
        var params = [String: String]()
        params[Constants.Keys.kAuthUserName] = Utilities.toString(object: Defaults[.userId])
        params[Constants.Keys.kAuthPassword] = Defaults[.token]
        return params
    }
    
    // Fetch
    func addAPI(paramDict: [String:AnyObject],completion: @escaping (Any?, Bool)-> Void) {
        
        NetworkManager.shared().getRequest(urlString: kBaseURL + APIName.addExp.rawValue, param: paramDict, authDict: self.getAuthParams(), completionHandler: { (response, success) in
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
    
    // Fetch
    func editExpAPI(paramDict: [String:AnyObject],completion: @escaping (Any?, Bool)-> Void) {
        
        NetworkManager.shared().getRequest(urlString: kBaseURL + APIName.editExp.rawValue, param: paramDict, authDict: self.getAuthParams(), completionHandler: { (response, success) in
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
    
    func deleteExpAPI(paramDict: [String:AnyObject],completion: @escaping (Any?, Bool)-> Void) {
        
        NetworkManager.shared().getRequest(urlString: kBaseURL + APIName.deleteExp.rawValue, param: paramDict, authDict: self.getAuthParams(), completionHandler: { (response, success) in
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
}
