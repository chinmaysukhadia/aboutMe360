//
//  MinRatingPopupViewController.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 29/09/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import UIKit

class MinRatingPopupViewController: BaseViewController {

    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var contentView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setuUp()
    }
    
    //MARK: - Private Methods
    
    private func setuUp() {
        self.contentView.roundCorners(8)
        self.okButton.roundCorners(4)
    }

    @IBAction func okButtonTapped(_ sender: Any) {
    self.dismiss(animated: false, completion: nil)
    }
    
}
