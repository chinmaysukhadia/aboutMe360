//
//  QuestionsDataModel.swift
//  AboutMe360
//
//  Created by Himanshu Pal Kumar on 29/09/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import Foundation
import UIKit
//struct QuestionsDataModel: NSObject {
//    var title: String
//    var rating: Int
//    var position: Int
//}


class QuestionsDataModel {
    var title: NSAttributedString
    var rating: Int
    var position: Int
    init(title: NSAttributedString,rating: Int,position: Int){
        self.title = title
        self.rating = rating
        self.position = position
    }
}
