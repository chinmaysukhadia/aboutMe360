//
//  ProfileViewController+UITableView.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 27/09/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import Foundation
import UIKit

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: OneTextFieldCell.className, for: indexPath) as? OneTextFieldCell {
            cell.selectionStyle = .none
            cell.imageViewCheck.isHidden = true
            cell.inputTextField.delegate = self
            cell.inputTextField.tag = indexPath.row
            cell.inputTextField.isUserInteractionEnabled = true
            
            switch indexPath.row {
            case 0:
                cell.inputTextField.placeholder = StringConstants.designation
                cell.inputTextField.text = self.designation
                cell.inputTextField.autocapitalizationType = .words
                
                cell.textDidChanged = { (cell,text) in
                    self.designation = text?.trim()
                    //  cell.imageViewCheck.isHidden =  self.designation?.count == 0 ? true :  false
                }
            case 1:
                cell.inputTextField.placeholder = StringConstants.lastOrganisation
                cell.inputTextField.text = self.lastOrganisation
                cell.inputTextField.autocapitalizationType = .words
                
                cell.textDidChanged = { (cell,text) in
                    self.lastOrganisation = text?.trim()
                    // cell.imageViewCheck.isHidden =  self.lastOrganisation?.count == 0 ? true :  false
                }
                
            case 2:
                cell.inputTextField.placeholder = StringConstants.industry
                cell.inputTextField.autocapitalizationType = .words
                cell.inputTextField.isUserInteractionEnabled = false
                cell.inputTextField.text = self.industry
                cell.inputTextField.addDoneButtonOnKeyboard()
                cell.initializationPiker(pikerdata: self.arrayIndustry)
                cell.imageViewCheck.image = UIImage(named: "drop_down")
                cell.imageViewCheck.isHidden = false
                cell.textDidChanged = { (cell,text) in
                    self.industry = text?.trim()
                }
                
            case 3:
                cell.inputTextField.placeholder = StringConstants.jobProfile
                cell.inputTextField.autocapitalizationType = .words
                cell.inputTextField.isUserInteractionEnabled = false
                cell.inputTextField.text = self.jobProfile
                cell.inputTextField.addDoneButtonOnKeyboard()
                cell.initializationPiker(pikerdata: self.arrayJobProfile)
                cell.imageViewCheck.image = UIImage(named: "drop_down")
                cell.imageViewCheck.isHidden = false
                cell.textDidChanged = { (cell,text) in
                    self.jobProfile = text?.trim()
                    // cell.imageViewCheck.isHidden =  self.jobProfile?.count == 0 ? true :  false
                }
            case 4:
                cell.inputTextField.placeholder = StringConstants.workLocation
                cell.inputTextField.autocapitalizationType = .words
                cell.inputTextField.isUserInteractionEnabled = false
                cell.inputTextField.text = self.workLocation
                cell.inputTextField.addDoneButtonOnKeyboard()
                cell.initializationPiker(pikerdata: self.arrayWorkLocation)
                cell.textDidChanged = { (cell,text) in
                    self.workLocation = text?.trim()
                    // cell.imageViewCheck.isHidden =  self.workLocation?.count == 0 ? true :  false
                }
                
            default:
                print("####")
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt")
        switch indexPath.row {
        case 2:
            self.selectData(seletedString: self.industry ?? "", index: indexPath.row, popType: .industry)
        case 3:
            self.selectData(seletedString: self.jobProfile ?? "", index: indexPath.row, popType: .profile)
        case 4:
            self.selectData(seletedString: self.workLocation ?? "", index: indexPath.row, popType: .location)
        default:
            print("####")
        }
    }
    
}
