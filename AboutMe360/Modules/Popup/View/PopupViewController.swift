//
//  PopupViewController.swift
//  AboutMe360
//
//  Created by Narendra Kumar on 13/11/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import UIKit


enum PopupType {
    
    case none
    case industry
    case profile
    case location
    
    var title : String? {
        switch self {
        case .industry:
            return "Select Industry"
        case .profile:
            return "Select Profile"
        case .none:
            return ""
        case .location:
            return "Select Location"
        }
    }
    
}

class PopupViewController: BaseViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var popupType : PopupType = .none
    var arrayDataSource = [String]()
    var selectedString = ""
    var selectedCategoryTapped: ((String)-> Void)?
    var popupViewModel: PopupViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.setUp()
    }
    
    //MARK: - Private Methods
    
    private func setUp() {
        
        self.setUpViewModel()
        
        if popupType == .industry, let industry = self.popupViewModel?.getIndustryDataSource() {
            self.arrayDataSource = industry
        }
        
        if popupType == .profile, let profile = self.popupViewModel?.getProfileDataSource() {
            self.arrayDataSource = profile
        }
        
        if popupType == .location, let location = self.popupViewModel?.getLocationDataSource() {
            self.arrayDataSource = location
        }
        
        self.titleLabel.text = popupType.title
        self.registerCell()
        Threads.performTaskInMainQueue {
            self.tableView.reloadData()
        }
    }
    
    private func registerCell() {
        tableView.register(nibs: [PopupCell.className])
    }
    
    // Model Initialization
    private func setUpViewModel() {
        popupViewModel = PopupViewModel()
    }
    
    @IBAction func okTapped(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
        self.selectedCategoryTapped?(selectedString)
    }
}


extension PopupViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayDataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: PopupCell.className, for: indexPath) as? PopupCell {
            cell.selectionStyle = .none
            cell.backgroundColor = .clear
            cell.configureCell(cellData: arrayDataSource[indexPath.row])
            if selectedString.trim() == arrayDataSource[indexPath.row].trim() {
                cell.radioImageView?.image = UIImage(named: "radio_selected")
            } else {
                cell.radioImageView?.image = UIImage(named: "radio_unselected")
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedString = arrayDataSource[indexPath.row].trim()
        self.tableView.reloadData()
    }
    
    
}
