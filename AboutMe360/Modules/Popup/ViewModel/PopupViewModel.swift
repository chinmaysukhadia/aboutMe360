//
//  PopupViewModel.swift
//  AboutMe360
//
//  Created by Narendra Kumar on 13/11/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import Foundation

class PopupViewModel {
    
    func getIndustryDataSource()-> [String]{
        
        return ["Banking/ NBFC Financial","Financial/ Non-Banking","FMCG","IT","Import/ Export Industry","Trading/ Retailing","Manufacturing","Professionals","Student","Others"]
    }
    
    func getProfileDataSource()-> [String]{
        
        return ["Sales","Operations","Finance Department","Risk/ Credit","Legal & Compliance","Analyst/ MIS", "Purchase","Strategy","Audit","Product Development", "Software Development","Artificial Intelligence","Chartered Accountant","Doctor","Lowyer","Architect/Iinterior","Professor/Lecturer/Teacher","Entrepreneur/Self/Employed","Others"]
    }
    
    func getLocationDataSource()-> [String]{
        
        return ["Andhra Pradesh","Andaman and Nicobar Islands","Arunachal Pradesh","Assam","Bihar","Chattisgarh", "Chandigarh", "Dadra and Nagar Haveli","Daman and Diu","Delhi", "Goa","Gujarat","Haryana", "Himachal Pradesh", "Jammu and Kashmir", "Jammu and Kashmir", "Karnataka", "Kerala","Lakshadweep","Madhya Pradesh","Maharashtra","Manipur","Meghalaya","Mizoram","Nagaland","Odisha","Puducherry","Punjab","Rajasthan","Sikkim","Tamil Nadu","Telangana","Tripura","Uttar Pradesh","Uttarakhand","West Bengal"]
    }
}
