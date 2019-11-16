//
//  FeedbackViewController.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 17/09/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import UIKit

class FeedbackViewController: BaseViewController {
    
    //MARK: - IBOUtlets
    
    @IBOutlet weak var notNowButton: UIButton!
    @IBOutlet weak var contentView: UIView!
    
    //MARK: - Variables

    //MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.setuUp()
    }
    
    //MARK: - Private Methods
    
    private func setuUp() {
        self.notNowButton.makeLayer(color: color.appBlueColor, boarderWidth: 1, round: 2)
        self.contentView.roundCorners(8)
    }
    
    //MARK: - IBAction

    @IBAction func crossButoonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func notNowButoonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func letsDoThisButoonTapped(_ sender: Any) {
        
        guard let feedbackRatingVC = DIConfigurator.feedbackRatingViewController() as? FeedbackRatingViewController  else {
            return
        }
        self.navigationController?.pushViewController(feedbackRatingVC, animated: true)
    }
    
}
