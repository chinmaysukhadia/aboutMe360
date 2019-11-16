//
//  DeactivationAccountViewController.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 16/09/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import UIKit
import UITextView_Placeholder
class DeactivationAccountViewController: BaseViewController {

    //MARK: - IBOutlets
    
    @IBOutlet weak var deactivateTableView: UITableView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var footerView: UIView!
    
    //MARK: - Variables
    
    //MARK: - Variables
    
    var dataDict:[String: String] = [:]
    var deactivationAccountViewModel: DeactivationAccountViewModel?
    
    var issue: String? {
        didSet {
            dataDict[Constants.Keys.kIssue] = issue
        }
    }
    
    var dataSource = ["This is temporary. I’ll be back.","I don’t find this app useful.","I get too many emails, invitations, and request from this app.","I have a privacy concern.","Other, please explain further"]
    var index = -1
    
    //MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setUp()
    }
    
    //MARK: - Private Methods
    
    private func setUp() {
        self.deactivateTableView.delegate = self
        self.deactivateTableView.dataSource = self
       //
     
        self.textView.placeholder = "Let us know your issue."

        footerView.isHidden = true
        self.registerCell()
        self.setUpViewModel()
    }
    
    private func registerCell() {
        deactivateTableView.register(nibs: [DeactivationAccountCell.className])
    }
    
    // Model Initialization
    private func setUpViewModel() {
        deactivationAccountViewModel = DeactivationAccountViewModel()
    }
    
    //MARK: - IBAction
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func deactivateButtonTapped(_ sender: Any) {
        
        if index >= 0 {
            
            self.deactivationAccountViewModel?.validateDeactivateFormData(dataDict: self.dataDict, completion: { (success, message) in
                if !success {
                    Utilities.showToast(message: message)
                } else {
                    
                    self.deactivationAccountViewModel?.deactivateAPI(paramDict: self.dataDict as [String : AnyObject],completion: { (_, success) in
                        
                        if success {
                            
                            Threads.performTaskInMainQueue {
//                                guard let deactivationCompleteVC = DIConfigurator.deactivationCompleteViewController() as? DeactivationCompleteViewController  else {
//                                    return
//                                }
//                                self.navigationController?.pushViewController(deactivationCompleteVC, animated: true)
                                  AppDelegate.delegate()?.showLogin()
                            }
                        }
                    })
                }
            })
        } else {
            Utilities.showToast(message: StringConstants.PleaseSelectResaon)
        }
    }

}


extension DeactivationAccountViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: DeactivationAccountCell.className, for: indexPath) as? DeactivationAccountCell {
            cell.selectionStyle = .none
            cell.titleLabel.text = dataSource[indexPath.row]
            //cell.backgView.makeLayer(color: UIColor.lightGray, boarderWidth: 1, round: 2)
            
            if index == indexPath.row {
                cell.titleLabel.textColor = .white
                cell.backgView.backgroundColor =  color.appBlueColor
                cell.backgView.makeLayer(color: UIColor.clear, boarderWidth: 0, round: 2)
            } else {
                cell.titleLabel.textColor = color.appDarkBlueColor
                cell.backgView.backgroundColor =  .white
                cell.backgView.makeLayer(color: UIColor.lightGray, boarderWidth: 1, round: 2)
            }
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        index = indexPath.row
        footerView.isHidden = true
        issue = dataSource[indexPath.row]
        
        if index == dataSource.count - 1 {
            footerView.isHidden = false
            issue = ""
        }
        
        Threads.performTaskInMainQueue {
            self.deactivateTableView.reloadData()
        }
    }

}

extension DeactivationAccountViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
       
        let currentText = textView.text ?? ""
        
        // attempt to read the range they are trying to change, or exit if we can't
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        // add their new text to the existing text
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        
        issue = updatedText

        
        return true
    }
    
}



