//
//  FeedbackCommentViewController.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 17/09/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import UIKit
import UITextView_Placeholder

class FeedbackCommentViewController: BaseViewController {
    
    //MARK: - IBOUtlets
    
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var textView: UITextView!
    
    //MARK: - Variables
    
    var rating = 0
    var dataDict: [String: String] = [:]
    var feedbackCommentViewModel: FeedbackCommentViewModel?
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.setuUp()
    }
    
    //MARK: - Private Methods
    
    private func setuUp() {
        self.viewBackground.roundCorners(8)
        self.contentView.roundCorners(8)
        self.textView.placeholder = "Help us enhance!"
        self.setUpViewModel()
    }
    
    // Model Initialization
    private func setUpViewModel() {
        feedbackCommentViewModel = FeedbackCommentViewModel()
    }
    
    //MARK: - IBAction
    
    @IBAction func crossButoonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submitButoonTapped(_ sender: Any) {
        
       let  comment = Utilities.toString(object: self.textView.text.trim())
        
        if !comment.isEmpty {
            dataDict[Constants.Keys.kRating] = Utilities.toString(object: self.rating)
            dataDict[Constants.Keys.kText] = comment
            self.feedbackCommentViewModel?.feedbackAPI(param: dataDict,completion: { (data, success) in
                
                if success {
                    self.navigationController?.popToRootViewController(animated: true)
                }
            })
            
        } else {
            Utilities.showToast(message: StringConstants.shareFeedBack)
        }
    }
}
