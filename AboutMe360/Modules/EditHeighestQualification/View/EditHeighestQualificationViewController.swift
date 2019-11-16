//
//  EditHeighestQualificationViewController.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 16/09/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import UIKit
import SwiftyUserDefaults
class EditHeighestQualificationViewController: BaseViewController {

    
    //MARK: - IBOutlets
    
    @IBOutlet weak var txtHighQualification: ACFloatingTextfield!
    @IBOutlet weak var imageViewHighQualificationCheck: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    //MARK: - Variables
    
    var dataDict: [String: String] = [:]
    var editHeighestQualificationViewModel: EditHeighestQualificationViewModel?
    var callBack: (() ->Void)?
    var hQualification:HQualification?
    var highQualification:String? {
        didSet {
            self.dataDict[Constants.Keys.kHighQualification] = highQualification
            //self.txtHighQualification.text = highQualification
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setUp()
    }
    
    //MARK: - Private Methods
    
    private func setUp() {
        self.imageViewHighQualificationCheck.isHidden =  true
        txtHighQualification.delegate = self
        self.dataDict[Constants.Keys.kID] = hQualification?.id
        highQualification = hQualification?.qualification
        txtHighQualification.text = highQualification
        self.txtHighQualification.autocapitalizationType = .words
        
//        if let name = Defaults[.profleData]?.homeData?.fullName {
//            nameLabel.text = "Hi " + name + "! Update Highest Qualification."
//        }
        
        self.setUpViewModel()
    }
    
    // Model Initialization
    private func setUpViewModel() {
        editHeighestQualificationViewModel = EditHeighestQualificationViewModel()
    }
    
    //MARK: - IBAction

    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func updateButtonTapped(_ sender: Any) {
        
        self.editHeighestQualificationViewModel?.validateFormData(dataDict: self.dataDict, completion: { (success, message) in
            if !success {
                Utilities.showToast(message: message)
            } else {
                
                self.editHeighestQualificationViewModel?.updateHeighestQualificationAPI(paramDict: self.dataDict,completion: { (_, success) in
                    
                    if success {
                        self.callBack?()
                        self.navigationController?.popViewController(animated: true)
                    }
                })
            }
        })
        
    }

}

extension EditHeighestQualificationViewController : UITextFieldDelegate  {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text, let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            switch textField {
            case txtHighQualification:
                self.highQualification = updatedText
            default:
                print("#####")
            }
            
        }
        return true
    }
}

