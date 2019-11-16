//
//  SearchViewController.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 17/09/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class SearchViewController: BaseViewController {
    
    //MARK: - IBOUtlets
    
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var loadMoreButton: UIButton!
    @IBOutlet weak var companyView: UIView!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var companyNameView: UIView!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var noResultFoundLabel: UILabel!
    @IBOutlet weak var linearProgressView: MDProgress!
    
    //MARK: - Variables
    
    var searchViewModel: SearchViewModel?
    var loginViewModel: LoginViewModel?
    var dataDict: [String: String] = [:]
    var arraySearchData = [SearchData]()
    var arrayCompanyData = [OrgName]()
    var isCompanySearch = false
    var progress:CGFloat = 0.0
    var isProgress = false

    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.

        self.setuUp()
    }
    
 
    
    //MARK: - Private Methods
    
    private func setuUp() {
        searchView.roundCorners(25)
        loadMoreButton.roundCorners(25)
        companyNameView.makeLayer(color: color.appBlueColor, boarderWidth: 1.5, round: 15)
        companyNameView.isHidden = true
        //backButton.isHidden = true
        txtSearch.returnKeyType = .search
        self.setUpViewModel()
        self.registerCell()
        txtSearch.addTarget(self, action: #selector(textChange), for: .editingChanged)
        //self.simulateProgress()
        linearProgressView.isHidden = true
        
        txtSearch.attributedPlaceholder = NSAttributedString(string: "Search Name/Email/Mobile Number",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
    }
    
    func simulateProgress() {
        
        if isProgress == false {
            return
        }
        
        linearProgressView.isHidden = false
        
        let  random = arc4random_uniform(5) + 1/100

        progress = progress + CGFloat(random)
        
        if progress > 1 {
            linearProgressView.progress = 1
            progress = 0.0
            Threads.performTaskAfterDealy(3) {
                self.simulateProgress()
            }
          
        } else {
            
            linearProgressView.progress = CGFloat(progress)
            Threads.performTaskAfterDealy(0.2) {
                self.simulateProgress()
            }
        }

    }
    
    private func registerCell() {
        searchTableView.register(nibs: [CompanyCell.className,SearchCell.className])
    }
    
    // Model Initialization
    private func setUpViewModel() {
        searchViewModel = SearchViewModel()
        loginViewModel = LoginViewModel()
    }
    
    func serachOrg(dict: [String:String],showLoader: Bool = true)  {
        
        self.isProgress = true
        self.simulateProgress()
        
        self.searchViewModel?.searchOrgAPI(paramDict: dict,showLoader,completion: { (responseData, success) in
            
             self.arrayCompanyData.removeAll()
            
            if success {
                
                if let data = responseData as? CompanyModel, let searchData = data.orgName, searchData.count > 0 {
                    self.arrayCompanyData = searchData
                    self.noResultFoundLabel.isHidden = true
                } else {
                    self.noResultFoundLabel.isHidden = false
                }
            } else {
                self.noResultFoundLabel.isHidden = false
            }
            
            self.isProgress = false
            self.linearProgressView.isHidden = true
                
             self.searchTableView.reloadData()
        })
    }
    
    func serachKeyword(dict: [String:String],showLoader: Bool = true)  {
        self.isProgress = true
        self.simulateProgress()
        
        self.searchViewModel?.searchKeywordsPI(paramDict: dict,showLoader,completion: { (responseData, success) in
            
            self.arraySearchData.removeAll()
            if success {
                if let data = responseData as? SearchModel, let searchData = data.searchData, searchData.count > 0 {
                    self.arraySearchData = searchData
                    self.noResultFoundLabel.isHidden = true
                } else {
                    self.noResultFoundLabel.isHidden = false
                }
            } else {
                self.noResultFoundLabel.isHidden = false
            }
            
            self.isProgress = false
            self.linearProgressView.isHidden = true
            
             self.searchTableView.reloadData()
        })
    }
    
    func checkString(string: String) -> Bool {
        
        let characterset = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
        if string.rangeOfCharacter(from: characterset.inverted) != nil {
            return false
        }
        
        return true
    }
    
    func checkNumeric(string: String) -> Bool {
        
        let characterset = CharacterSet(charactersIn: "0123456789")
        if string.rangeOfCharacter(from: characterset.inverted) != nil {
            return false
        }
        
        return true
    }
    
    func getProfileData(selectedID: String) {
        
        self.loginViewModel?.profileAPI(authDict: nil, param: [Constants.Keys.kUserID: selectedID as AnyObject],completion: { (data, success) in
            
            if success {
                
                if let searchData =  data as? HomeModel {
                    Threads.performTaskInMainQueue {
                        guard let otherProfileVC = DIConfigurator.otherProfileViewController() as? OtherProfileViewController  else {
                            return
                        }
                        otherProfileVC.homeModel = searchData
                        self.navigationController?.pushViewController(otherProfileVC, animated: true)
                    }
                }
            }
        })
    }
    
    //MARK: - IBAction
    
    @IBAction func backTapped(_ sender: Any) {
        
        if self.backButton.isSelected == false {
            
            if let searchText = txtSearch.text?.trim(), searchText.isEmpty {
                if  let viewController = AppDelegate.delegate()?.window!.rootViewController as? TabbarViewController {
                    if let selected  = Defaults[.selectedIndex] {
                        viewController.selectedIndex = selected
                    }
                }
            }
                    
            txtSearch.text = ""
            arrayCompanyData.removeAll()
            arraySearchData.removeAll()
            self.searchTableView.reloadData()
                        
            return
        }
        
        self.filterButton.isSelected = false
        txtSearch.text = ""
        self.filterButton.setTitle("Company Filter", for: .normal)
        self.isCompanySearch = false
        txtSearch.attributedPlaceholder = NSAttributedString(string: "Search Name/Email/Mobile Number",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
       // backButton.isHidden = true
        self.backButton.setTitle("Cancel", for: .normal)
        self.backButton.isSelected = false
        companyNameView.isHidden = true
        self.companyLabel.text  = ""
        arrayCompanyData.removeAll()
        self.searchTableView.reloadData()
    }
    
    @IBAction func filterTapped(_ sender: Any) {
        self.filterButton.isSelected =  !self.filterButton.isSelected
        txtSearch.text = ""
        self.noResultFoundLabel.isHidden = true
        
        if self.filterButton.isSelected {
            self.filterButton.setTitle("Clear Filter", for: .normal)
            self.isCompanySearch = true
            txtSearch.attributedPlaceholder = NSAttributedString(string: "Search Company",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
           // backButton.isHidden = false
            arraySearchData.removeAll()
            self.backButton.setTitle("Back", for: .normal)
            self.backButton.isSelected = true
            self.searchTableView.reloadData()
        } else {
            self.filterButton.setTitle("Company Filter", for: .normal)
            self.isCompanySearch = false
            txtSearch.attributedPlaceholder = NSAttributedString(string: "Search Name/Email/Mobile Number",
                       attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
            //backButton.isHidden = true
            self.backButton.setTitle("Cancel", for: .normal)
            self.backButton.isSelected = false
            companyNameView.isHidden = true
            self.companyLabel.text  = ""
            arrayCompanyData.removeAll()
            arraySearchData.removeAll()
            self.searchTableView.reloadData()
        }
    }
    
    func search(showLoader: Bool)  {
        
        let text = Utilities.toString(object: self.txtSearch.text?.trim())
        
        if text.isEmpty {
            return
        }
                
        if self.isCompanySearch {
            self.serachOrg(dict: [Constants.Keys.kSearchInput: text],showLoader: showLoader)
            return
        }
        
        var param: [String: String] = [:]
        
        if let filer = self.companyLabel.text?.trim() {
            param[Constants.Keys.kFilter] = filer
        } else {
            param[Constants.Keys.kFilter] = ""
        }
        
        if self.checkString(string: text) {
            param[Constants.Keys.kName] = text
            self.serachKeyword(dict: param,showLoader: showLoader)
        } else if self.checkNumeric(string: text) {
            param[Constants.Keys.kMobileNumer] = text
            self.serachKeyword(dict: param,showLoader: showLoader)
        } else {
            param[Constants.Keys.kEmail] = text
            self.serachKeyword(dict: param,showLoader: showLoader)
        }
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        self.view.endEditing(true)
        
        if let numerOfSearch = Defaults[.numberOfSearch] {
            
            Defaults[.numberOfSearch] = numerOfSearch + 1
            
            if numerOfSearch + 1 == 10 {
                Defaults[.numberOfSearch] = 0
                
                guard let feedbackViewController = DIConfigurator.feedbackViewController() as? FeedbackViewController  else {
                    return
                }
                self.navigationController?.pushViewController(feedbackViewController, animated: true)
                return
            }
            
        } else {
            Defaults[.numberOfSearch] = 1
        }
        
        self.search(showLoader: false)
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.isCompanySearch {
            return self.arrayCompanyData.count
        }
        return self.arraySearchData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.isCompanySearch {
            if let cell = tableView.dequeueReusableCell(withIdentifier: CompanyCell.className, for: indexPath) as? CompanyCell {
                cell.selectionStyle = .none
                cell.backgroundColor = .clear
                cell.configureCell(cellData: self.arrayCompanyData[indexPath.row])
                return cell
            }
        }
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.className, for: indexPath) as? SearchCell {
            cell.selectionStyle = .none
            cell.backgroundColor = .clear
            cell.configureCell(cellData: self.arraySearchData[indexPath.row])
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if self.isCompanySearch {
            self.isCompanySearch = false
            txtSearch.text = ""
            txtSearch.attributedPlaceholder = NSAttributedString(string: "Search Name/Email/Mobile Number",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
            self.companyLabel.text = self.arrayCompanyData[indexPath.row].name
            self.companyNameView.isHidden = false
            arrayCompanyData.removeAll()
            self.searchTableView.reloadData()
            return
        }
        
        if let id = self.arraySearchData[indexPath.row].id {
            self.getProfileData(selectedID: id)
        }
    }
    
    @objc func textChange(_ textField: UITextField) {
        
        if let text = textField.text, text.count > 2 {
            self.search(showLoader: false)
        }
    }
    
}

extension SearchViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.search(showLoader: false)
        return true
    }
}
