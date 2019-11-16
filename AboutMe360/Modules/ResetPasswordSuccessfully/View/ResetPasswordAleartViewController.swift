//
//  ResetPasswordAleartViewController.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 16/09/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import UIKit

class ResetPasswordAleartViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: - IBAction

    @IBAction func loginButtonTapped(_ sender: Any) {
        
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: LoginViewController.self) {
                self.navigationController?.popToViewController(controller, animated: true)
                break
            }
        }
       // self.navigationController?.popToRootViewController(animated: true)
    }
    

}
