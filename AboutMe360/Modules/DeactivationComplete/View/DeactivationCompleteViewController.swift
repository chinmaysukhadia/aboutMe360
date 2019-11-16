//
//  DeactivationCompleteViewController.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 16/09/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import UIKit

class DeactivationCompleteViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func okeyButtonTapped(_ sender: Any) {
     self.navigationController?.popToRootViewController(animated: true)
    }
    

}
