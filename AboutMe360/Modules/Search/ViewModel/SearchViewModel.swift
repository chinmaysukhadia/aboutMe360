//
//  SearchViewModel.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 29/09/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

class SearchViewModel {
    
    // Fetch
    func searchKeywordsPI(paramDict: [String:String],_ showLoader: Bool = true ,completion: @escaping (Any?, Bool)-> Void) {
        
        NetworkManager.shared().getRequest(urlString: self.getSearchKeywordURL(dict: paramDict), param: nil, authDict: self.getAuthParams(),showLoader, completionHandler: { (response, success) in
            if success {
                
                if let safeResponse =  response as? [String: AnyObject] {
                    print(safeResponse)
                    let model = SearchModel.formattedDataDict(data: safeResponse)
                    completion(model,true)
                    return
                }
            }
            
            completion(nil,false)
        })
    }
    
    private func getAuthParams()-> [String: String] {
        var params = [String: String]()
        params[Constants.Keys.kAuthUserName] = Utilities.toString(object: Defaults[.userId])
        params[Constants.Keys.kAuthPassword] = Defaults[.token]
        return params
    }
    
    private func getSearchKeywordURL(dict: [String: String])-> String {
        var params = [String: String]()
        params[Constants.Keys.kName] = Utilities.toString(object: dict[Constants.Keys.kName]?.trim())
        params[Constants.Keys.kEmail] = Utilities.toString(object:dict[Constants.Keys.kEmail]?.trim())
        params[Constants.Keys.kMobileNumer] = Utilities.toString(object:dict[Constants.Keys.kMobileNumer]?.trim())
        params[Constants.Keys.kFilter] = Utilities.toString(object:dict[Constants.Keys.kFilter]?.trim())
        params[Constants.Keys.kLastID] = Utilities.toString(object:dict[Constants.Keys.kLastID]?.trim())
        let url = kBaseURL + APIName.searchKeyword.rawValue+params.queryString
       // let escapedString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        return url
    }
    
    func searchOrgAPI(paramDict: [String:String],_ showLoader: Bool = true, completion: @escaping (Any?, Bool)-> Void) {
        
        NetworkManager.shared().getRequest(urlString: self.getSearchOrgURL(dict: paramDict), param: nil, authDict: self.getAuthParams(),showLoader, completionHandler: { (response, success) in
            if success {
                
                if let safeResponse =  response as? [String: AnyObject] {
                    print(safeResponse)
                    let model = CompanyModel.formattedDataDict(data: safeResponse)
                    completion(model,true)
                    return
                }
            }
            completion(nil,false)
        })
    }
    
    private func getSearchOrgURL(dict: [String: String])-> String {
        let url = kBaseURL + APIName.searchOrg.rawValue+dict.queryString
        return url
    }
 
    //searchOrg
}
