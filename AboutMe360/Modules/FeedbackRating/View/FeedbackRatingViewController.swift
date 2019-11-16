//
//  FeedbackRatingViewController.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 17/09/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import UIKit

class FeedbackRatingViewController: BaseViewController {

    //MARK: - IBOUtlets

    @IBOutlet weak var angaryButton: UIButton!
    @IBOutlet weak var sadButton: UIButton!
    @IBOutlet weak var confusedButton: UIButton!
    @IBOutlet weak var smileButton: UIButton!
    @IBOutlet weak var happyButton: UIButton!
    
    @IBOutlet weak var angaryLabel: UILabel!
    @IBOutlet weak var sadLabel: UILabel!
    @IBOutlet weak var confusedLabel: UILabel!
    @IBOutlet weak var smileLabel: UILabel!
    @IBOutlet weak var happyLabel: UILabel!
    @IBOutlet weak var contentView: UIView!

    
    //MARK: - Variables
    var rating = 0
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setuUp()
    }
    
    //MARK: - Private Methods
    
    private func setuUp() {
        self.contentView.roundCorners(8)
    }
    
    private func buttonSelected(sender:UIButton) {
        
        self.angaryButton.isSelected = false
        self.sadButton.isSelected = false
        self.confusedButton.isSelected = false
        self.smileButton.isSelected = false
        self.happyButton.isSelected = false
        sender.isSelected = true
    }
    
    private func labelHighlighted(label:UILabel) {
        
        self.angaryLabel.textColor = .lightGray
        self.sadLabel.textColor = .lightGray
        self.confusedLabel.textColor = .lightGray
        self.smileLabel.textColor = .lightGray
        self.happyLabel.textColor = .lightGray
        label.textColor = .black
    }
    
    //MARK: - IBAction
    
    @IBAction func crossButoonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func angaryButtonTapped(_ sender: Any) {
        self.buttonSelected(sender: self.angaryButton)
        self.labelHighlighted(label: self.angaryLabel)
        rating = 1
    }
    
    @IBAction func sadButtonTapped(_ sender: Any) {
        self.buttonSelected(sender: self.sadButton)
        self.labelHighlighted(label: self.sadLabel)
        rating = 2
    }
    
    @IBAction func confusedButtonTapped(_ sender: Any) {
        self.buttonSelected(sender: self.confusedButton)
        self.labelHighlighted(label: self.confusedLabel)
        rating = 3
    }
    
    @IBAction func smileButtonTapped(_ sender: Any) {
        self.buttonSelected(sender: self.smileButton)
        self.labelHighlighted(label: self.smileLabel)
        rating = 4
    }
    
    @IBAction func happyButtonTapped(_ sender: Any) {
        self.buttonSelected(sender: self.happyButton)
        self.labelHighlighted(label: self.happyLabel)
        rating = 5
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
       
        if rating == 0 {
            Utilities.showToast(message: StringConstants.pleaseSelectYourExperience)
            return
        }
        
        guard let feedbackCommentVC = DIConfigurator.feedbackCommentViewController() as? FeedbackCommentViewController  else {
            return
        }
        feedbackCommentVC.rating = rating
        self.navigationController?.pushViewController(feedbackCommentVC, animated: true)
    }

}
