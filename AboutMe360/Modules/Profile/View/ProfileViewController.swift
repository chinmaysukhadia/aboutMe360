//
//  ProfileViewController.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 15/09/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

enum SignType {
    
    case none
    case signUp
    case edit
    case addNew
    
    var title : String? {
        switch self {
        case .signUp:
            return "Profile Final Step"
        case .edit:
            return "Edit Your Experience"
        case .none:
            return ""
        case .addNew:
            return "Add Your Experience"
        }
    }
    
}

class ProfileViewController: BaseViewController {
    
    //MARK: - IBOUtlets
    
    @IBOutlet weak var profileTableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var updateButtonView: UIStackView!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var txtStartDate: UITextField!
    @IBOutlet weak var txtEndDate: UITextField!
    @IBOutlet weak var switchCurrentlyWorking: UISwitch!
    
    
    //MARK: - Variables
    
    var designation: String? {
        didSet {
            dataDict[Constants.Keys.kDesignation] = designation
        }
    }
    
    var lastOrganisation: String? {
        didSet {
            dataDict[Constants.Keys.kOrgName] = lastOrganisation
        }
    }
    
    var industry: String? {
        didSet {
            dataDict[Constants.Keys.kIndustry] = industry
        }
    }
    
    var jobProfile: String? {
        didSet {
            dataDict[Constants.Keys.kJobProfile] = jobProfile
        }
    }
    
    var workLocation: String? {
        didSet {
            dataDict[Constants.Keys.kWorkLocation] = workLocation
        }
    }
    
    var startDate: String? {
        didSet {
            //dataDict[Constants.Keys.kStartDate] = startDate
            self.txtStartDate.text = startDate
            self.duration()
        }
    }
    
    var endDate: String? {
        didSet {
            //dataDict[Constants.Keys.kEndDate] = endDate
            self.txtEndDate.text = endDate
            self.duration()
        }
    }
    
    var isCurrentlyWorking: Int? {
        didSet {
            dataDict[Constants.Keys.kCurrentlyWorking] = Utilities.toString(object: isCurrentlyWorking)
        }
    }
    
    var signType : SignType = .none
    var startDatePicker =  UIDatePicker()
    var endDatePicker =  UIDatePicker()
    var dataDict: [String: String] = [:]
    var profileViewModel: ProfileViewModel?
    var arrayIndustry = [String]()
    var arrayJobProfile = [String]()
    var arrayWorkLocation = [String]()
    var callBack: (() ->Void)?
    var experience:Experience?
    var isDelete:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.setuUp()
    }
    
    //MARK: - Private Methods
    
    private func setuUp() {
        
        self.titleLabel.text = signType.title
        isCurrentlyWorking = 0
        self.switchCurrentlyWorking.isOn = false
        dataDict[Constants.Keys.kFullName] = Defaults[.name]
        self.setUpViewModel()
        
        if let industry = self.profileViewModel?.getIndustryDataSource() {
            self.arrayIndustry = industry
        }
        
        if let profile = self.profileViewModel?.getProfileDataSource() {
            self.arrayJobProfile = profile
        }
        
        if let location = self.profileViewModel?.getLocationDataSource() {
            self.arrayWorkLocation = location
        }
        
        if signType == .signUp {
            self.createButton.isHidden = false
            self.updateButtonView.isHidden = true
            
        } else  if signType == .edit {
            self.createButton.isHidden = true
            self.updateButtonView.isHidden = false
            
            if isDelete {
                self.deleteButton.backgroundColor = .lightGray
            }
            
            
            if let exp = self.experience {
                
                self.designation = exp.designation
                self.lastOrganisation = exp.orgName
                self.industry = exp.industry
                self.jobProfile = exp.jobProfile
                self.workLocation = exp.workLocation
                self.isCurrentlyWorking = Utilities.toInt(exp.currentlyWorking)
                
                let dateString = Utilities.toString(object: exp.duration).components(separatedBy: ",")
                
                if self.isCurrentlyWorking == 1 {
                    self.switchCurrentlyWorking.isOn = true
                    if dateString.count > 0 {
                        self.startDate = dateString[0]
                    }
                } else {
                    if dateString.count > 1 {
                        self.endDate = dateString[1]
                    }
                    self.switchCurrentlyWorking.isOn = false
                }
                
                dataDict[Constants.Keys.kExpID] = exp.id 
            }
            
        } else {
            self.createButton.isHidden = false
            self.updateButtonView.isHidden = true
        }
        
        self.startDatePicker.datePickerMode = .date
        txtStartDate.inputView = self.startDatePicker
        self.startDatePicker.tag = 101
        txtStartDate.addDoneButtonOnKeyboard(false)
        self.startDatePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        
        self.endDatePicker.datePickerMode = .date
        txtEndDate.inputView = self.endDatePicker
        self.endDatePicker.tag = 102
        txtEndDate.addDoneButtonOnKeyboard(false)
        self.endDatePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        
        registerCell()
    }
    
    private func registerCell() {
        profileTableView.register(nibs: [OneTextFieldCell.className])
    }
    
    // Model Initialization
    private func setUpViewModel() {
        profileViewModel = ProfileViewModel()
    }
    
    @objc func dateChanged(_ sender: UIDatePicker) {
        if sender.tag == 101 {
            startDate = sender.date.dateStringWith(strFormat: DateFormate.ddMMyyyy)
        } else {
            endDate = sender.date.dateStringWith(strFormat: DateFormate.ddMMyyyy)
        }
    }
    
    func duration() {
        
        if let sDate = self.startDate, let eDate = self.endDate {
            dataDict[Constants.Keys.kDuration] = sDate + "," + eDate
        } else {
            dataDict[Constants.Keys.kDuration] = self.startDate
        }
    }
    
    func selectData(seletedString: String, index:Int, popType: PopupType){
        
        if let popup = DIConfigurator.popupViewController() as? PopupViewController {
            popup.selectedString = seletedString
            popup.popupType = popType
            popup.view.backgroundColor = .clear
            popup.modalPresentationStyle = .overFullScreen
            popup.selectedCategoryTapped = { (text) in
                
                if index == 2 {
                    self.industry = text.trim()
                    Threads.performTaskInMainQueue {
                        self.profileTableView.reloadData()
                    }
                    self.selectData(seletedString: self.jobProfile ?? "", index: 3, popType: .profile)
                } else  if index == 3 {
                    self.jobProfile = text.trim()
                    Threads.performTaskInMainQueue {
                        self.profileTableView.reloadData()
                    }
                    self.selectData(seletedString: self.workLocation ?? "", index: 4, popType: .location)
                }  else  if index == 4 {
                    Threads.performTaskInMainQueue {
                        self.profileTableView.reloadData()
                    }
                    self.workLocation = text.trim()
                }
                
            }
            
            Threads.performTaskAfterDealy(0.1) {
                self.present(popup, animated: false)
            }
        }
    }
    //MARK: - IBAction
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func currentlyButtonTapped(_ sender: UISwitch) {
        isCurrentlyWorking = Utilities.toInt(sender.isOn)
        if sender.isOn {
            // self.endDate = ""
        }
    }
    
    @IBAction func createButtonTapped(_ sender: Any) {
        
        if signType == .signUp {
            
            self.profileViewModel?.validateProfileFormData(dataDict: self.dataDict, completion: { (success, message) in
                if !success {
                    Utilities.showToast(message: message)
                } else {
                    
                    self.profileViewModel?.createAPI(paramDict: self.dataDict ,completion: { (_, success) in
                        
                        if success {
                            Defaults[.isProfileCreated]  = nil
                            AppDelegate.delegate()?.showTabBar()
                        }
                    })
                }
            })
        } else if signType == .edit {
            
            
            
        } else if signType == .addNew {
            
            self.profileViewModel?.validateProfileFormData(dataDict: self.dataDict, completion: { (success, message) in
                if !success {
                    Utilities.showToast(message: message)
                } else {
                    
                    self.profileViewModel?.addAPI(paramDict: self.dataDict as [String : AnyObject],completion: { (_, success) in
                        
                        if success {
                            self.callBack?()
                            self.navigationController?.popViewController(animated: true)
                        }
                    })
                }
            })
            
        }
        
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        
        if isDelete {
            return
        }
        
        if let exp = self.experience {
            
            self.profileViewModel?.deleteExpAPI(paramDict: [Constants.Keys.kID: exp.id as AnyObject],completion: { (_, success) in
                
                if success {
                    self.callBack?()
                    self.navigationController?.popViewController(animated: true)
                }
            })
        }
        
    }
    
    @IBAction func updateButtonTapped(_ sender: Any) {
        
        self.profileViewModel?.validateProfileFormData(dataDict: self.dataDict, completion: { (success, message) in
            if !success {
                Utilities.showToast(message: message)
            } else {
                
                self.profileViewModel?.editExpAPI(paramDict: self.dataDict as [String : AnyObject],completion: { (_, success) in
                    
                    if success {
                        self.callBack?()
                        self.navigationController?.popViewController(animated: true)
                    }
                })
            }
        })
    }
    
}

extension ProfileViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField.tag == 1 {
            self.selectData(seletedString: self.industry ?? "", index: 2, popType: .industry)
        }
        textField.resignFirstResponder()


        return true
    }
}
