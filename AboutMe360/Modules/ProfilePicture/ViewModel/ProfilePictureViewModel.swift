//
//  ProfilePictureViewModel.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 23/09/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

class ProfilePictureViewModel {
    
    func validateProfilePictureFormData(dataDict: [String : String], completion: ((Bool, String)-> Void)?) {
        
        let highQualification = (dataDict[Constants.Keys.kHighQualification] ?? "").trim()
      //  let profileImg = (dataDict[Constants.Keys.kProfileImg] ?? "").trim()
        
        if highQualification.isEmpty {
            completion?(false,StringConstants.enterHighQualification)
            return
        }
        
//        if profileImg.isEmpty {
//            completion?(false,StringConstants.PleaseUploadProfilePiture)
//            return
//        }
        
        completion?(true, "")
    }
}
