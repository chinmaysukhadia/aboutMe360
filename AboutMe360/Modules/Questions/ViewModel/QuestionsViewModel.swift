//
//  QuestionsViewModel.swift
//  AboutMe360
//
//  Created by Himanshu Pal Kumar on 29/09/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import Foundation
import SwiftyUserDefaults
import UIKit

class QuestionsViewModel {

    
    func getDataSource() -> [QuestionsDataModel] {
        
        var array = [QuestionsDataModel]()
        
        var formattedString = NSMutableAttributedString()
        formattedString
            .bold("Task-oriented")
            .normal("/ Passion to perform/ Commitment/ Hard Working/ Adhere to deadlines")
        
        let ques1  = QuestionsDataModel.init(title: formattedString, rating: 0,position: 0)
        array.append(ques1)
        
        formattedString = NSMutableAttributedString()
        formattedString
                   .bold("Subject matter expert")
                   .normal(" (Knowledge about work/Technical proficiency)")
        let ques2  = QuestionsDataModel.init(title: formattedString, rating: 0,position: 1)
        array.append(ques2)
        
        formattedString = NSMutableAttributedString()
        formattedString
        .normal("Believes in ")
        .bold("Quality of Work")
        .normal("/ Meticulous/ Multi-tasking skill")

        let ques3  = QuestionsDataModel.init(title: formattedString, rating: 0,position: 2)
        array.append(ques3)
        
        formattedString = NSMutableAttributedString()
        formattedString
        .bold("Change management skills")
        .normal(" / Takes Initiatives/ Proactive/ Creative thinking/ Analytical/ Logical in approach/ Adaptable to change")
        
        let ques4  = QuestionsDataModel.init(title: formattedString, rating: 0,position: 3)
        array.append(ques4)
        
        formattedString = NSMutableAttributedString()
               formattedString
               .bold("Leadership Qualities")
        
        let ques5  = QuestionsDataModel.init(title: formattedString, rating: 0,position: 4)
        array.append(ques5)
        
        formattedString = NSMutableAttributedString()
                      formattedString
                      .bold("Solution Oriented")
        
        let ques6  = QuestionsDataModel.init(title: formattedString, rating: 0,position: 5)
        array.append(ques6)
        
        formattedString = NSMutableAttributedString()
                             formattedString
                             .bold("Stress Management")
        .normal(" quality")
        
        let ques7  = QuestionsDataModel.init(title: formattedString, rating: 0,position: 6)
        array.append(ques7)
        
        formattedString = NSMutableAttributedString()
                                    formattedString
                                    .bold("Unbiased/Motivates")
         .normal(" and Guides the team.")
        
        let ques8  = QuestionsDataModel.init(title: formattedString, rating: 0,position: 7)
        array.append(ques8)
        
        
        formattedString = NSMutableAttributedString()
                                           formattedString
                                            .normal("Frequently ")
                                           .bold("Recognises the team,")
                .normal(" Team members achievements in the open forum and encourages it, Grooms them for next level.")
        
        let ques9  = QuestionsDataModel.init(title:formattedString, rating: 0,position: 8)
        array.append(ques9)
        

        formattedString = NSMutableAttributedString()
                                   formattedString
                                   .bold("Open to suggestions")
        .normal("/ Takes feedback positively.")
        
        
        let ques10  = QuestionsDataModel.init(title: formattedString, rating: 0,position: 9)
        array.append(ques10)
        
        formattedString = NSMutableAttributedString()
                                          formattedString
                                          .bold("Conflict Resolution ")
        
        let ques11  = QuestionsDataModel.init(title: formattedString, rating: 0,position: 10)
        array.append(ques11)
        
        formattedString = NSMutableAttributedString()
        formattedString
        .bold("Polite")
        
        let ques12  = QuestionsDataModel.init(title: formattedString, rating: 0,position: 11)
        array.append(ques12)
        
        formattedString = NSMutableAttributedString()
        formattedString
        .bold("Anger Management")
        .normal(" ( 5 is well balanced head and manages anger well)")
        
        let ques13  = QuestionsDataModel.init(title:formattedString, rating: 0,position: 12)
        array.append(ques13)
        
        formattedString = NSMutableAttributedString()
        formattedString
        .bold("Approachable, Understanding")
        .normal(" and Empathising")
        
        let ques14  = QuestionsDataModel.init(title: formattedString, rating: 0,position: 13)
        array.append(ques14)
        
        formattedString = NSMutableAttributedString()
        formattedString
        .bold("Good Listener")
        
        let ques15  = QuestionsDataModel.init(title: formattedString, rating: 0,position: 14)
        array.append(ques15)
        
        formattedString = NSMutableAttributedString()
               formattedString
               .bold("Communication skills")
        
        let ques16  = QuestionsDataModel.init(title: formattedString, rating: 0,position: 15)
        array.append(ques16)
        

        formattedString = NSMutableAttributedString()
               formattedString
               .bold("Code of Conduct")
               .normal("/ Discipline / Integrity")
        
        let ques17  = QuestionsDataModel.init(title: formattedString, rating: 0,position: 16)
        array.append(ques17)
        
        formattedString = NSMutableAttributedString()
        formattedString
        .bold("Credibility")
        .normal(" (Does not use short cuts by ignoring rules, processes)")

        let ques18  = QuestionsDataModel.init(title: formattedString, rating: 0,position: 17)
        array.append(ques18)
        
        formattedString = NSMutableAttributedString()
               formattedString
               .bold("Relationship management")
               .normal(", relationship with stakeholders /peers")

        let ques19  = QuestionsDataModel.init(title: formattedString, rating: 0,position: 18)
        array.append(ques19)
        
        formattedString = NSMutableAttributedString()
                      formattedString
                      .normal("Behaviour towards opposite sex (")
        .bold("POSH")
        .normal(" related)")
        let ques20  = QuestionsDataModel.init(title: formattedString, rating: 0,position: 19)
        array.append(ques20)
        
        return array
    }
    
    func selfRatingAPI(paramDict: [String:String],completion: @escaping (Any?, Bool)-> Void) {
        
        NetworkManager.shared().getRequest(urlString: self.getSelfRatingURL(dict: paramDict), param: nil, authDict: self.getAuthParams(), completionHandler: { (response, success) in
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
    
    private func getSelfRatingURL(dict: [String: String])-> String {
        let url = kBaseURL + APIName.selfRating.rawValue+dict.queryString
        return url
    }
    
    private func getAuthParams()-> [String: String] {
        var params = [String: String]()
        params[Constants.Keys.kAuthUserName] = Utilities.toString(object: Defaults[.userId])
        params[Constants.Keys.kAuthPassword] = Defaults[.token]
        return params
    }
    
    func otherRatingAPI(paramDict: [String:String],completion: @escaping (Any?, Bool)-> Void) {
        
        NetworkManager.shared().getRequest(urlString: self.getOtherRatingURL(dict: paramDict), param: nil, authDict: self.getAuthParams(), completionHandler: { (response, success) in
            if success {
                
                if let safeResponse =  response as? [String: AnyObject] {
                    print(safeResponse)
                    completion(nil,true)
                }
            }
            
            if let safeResponse =  response as? [String: AnyObject], let message = safeResponse[Constants.Keys.kMessage] as? String {
                Utilities.showToast(message: message)
            }
        })
    }
    
    private func getOtherRatingURL(dict: [String: String])-> String {
        let url = kBaseURL + APIName.rateMe.rawValue+dict.queryString
        return url
    }
    
}
