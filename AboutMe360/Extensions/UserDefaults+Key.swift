//
//  UserDefaults+Key.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 9/22/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import SwiftyUserDefaults
import UIKit

extension UserDefaults {
    
    subscript(key: DefaultsKey<HomeModel?>) -> HomeModel? {
        get { return unarchive(key)  }
        set { archive(key, newValue) }
    }
}

extension DefaultsKeys {
    static let deviceToken = DefaultsKey<String?>("deviceToken")
    static let authToken = DefaultsKey<String?>("authToken")
    static let token = DefaultsKey<String?>("token")
    static let userId = DefaultsKey<Int?>("userId")
    static let name = DefaultsKey<String?>("name")
    static let profleData = DefaultsKey<HomeModel?>("profleData")
    static let numberOfSearch = DefaultsKey<Int?>("numberOfSearch")
    static let isLogin = DefaultsKey<Bool?>("isLogin")
    static let selectedIndex = DefaultsKey<Int?>("selectedIndex")
    static let isProfileCreated = DefaultsKey<Bool?>("isProfileCreated")


}
