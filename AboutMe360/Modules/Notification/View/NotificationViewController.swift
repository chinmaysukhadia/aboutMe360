//
//  NotificationViewController.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 17/09/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import UIKit

class NotificationViewController: BaseViewController {
    
    
    //MARK: - IBOUtlets
    
    @IBOutlet weak var notificationTableView: UITableView!
    @IBOutlet weak var noNotificationLabel: UILabel!
    @IBOutlet weak var loadMoreButton: UIButton!

    //MARK: - Variables
    
    var notificationViewModel: NotificationViewModel?
    var arrayDataSource = [NotifiData]()
    var loginViewModel: LoginViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.setuUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.noNotificationLabel.isHidden = true
        self.getNotification(lastID: 0)
    }
    
    //MARK: - Private Methods
    
    private func setuUp() {
        registerCell()
        self.setUpViewModel()
        loadMoreButton.roundCorners(20)
        loadMoreButton.isHidden = true
    }
    
    private func registerCell() {
        notificationTableView.register(nibs: [NotificationCell.className,NotificationHeaderCell.className])
    }
    
    // Model Initialization
    private func setUpViewModel() {
        notificationViewModel = NotificationViewModel()
        loginViewModel = LoginViewModel()
    }
    
    func getNotification(lastID: Int) {
        
        self.notificationViewModel?.getNotificationAPI(paramDict: [Constants.Keys.kLastID :lastID as AnyObject],completion: { (responseData, success) in
            
//            if lastID == 0 {
//                self.arrayDataSource.removeAll()
//            }
            
            if success {
               // loadMoreButton.isHidden = true

                if let data = responseData as? NotificationModel, let  notifiData =  data.notifiData{
                    
                self.loadMoreButton.isHidden = notifiData.count  > 9 ? false : true

                    if lastID == 0 {
                         self.arrayDataSource = notifiData
                    } else {
                        self.arrayDataSource.append(contentsOf: notifiData)
                    }
                   
                    Threads.performTaskInMainQueue {
                        self.notificationTableView.reloadData()
                    }
                }
            } else {
                self.loadMoreButton.isHidden = true
            }
            
            self.noNotificationLabel.isHidden = false

            if self.arrayDataSource.count > 0  {
                self.noNotificationLabel.isHidden = true
            }
            
        })
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
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func loadmoreTapped(_ sender: Any) {
    
    }
    
}

extension NotificationViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayDataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: NotificationCell.className, for: indexPath) as? NotificationCell {
            cell.selectionStyle = .none
            cell.backgroundColor = .clear
            cell.delegate = self
            cell.configureCell(cellData: arrayDataSource[indexPath.row])
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let id = self.arrayDataSource[indexPath.row].ratedBy {
            self.getProfileData(selectedID: id)
        }
    }
    
}

extension NotificationViewController: NotificationCellDelegate {
    
    func didTapAcceptNotificationCell(cell: NotificationCell) {
        
        guard let indexPath = self.notificationTableView.indexPath(for: cell) else {
            return
        }
        
        let cellData = arrayDataSource[indexPath.row]
        self.notificationViewModel?.acceptAPI(paramDict: [Constants.Keys.kTempRatingID : cellData.ratingId ?? ""],completion: { (responseData, success) in
            
            self.arrayDataSource.removeAll()
            
            if success {
                self.getNotification(lastID: 0)
            }
        })

    }
    
    func didTapDeclinNotificationCell(cell: NotificationCell) {
        guard let indexPath = self.notificationTableView.indexPath(for: cell) else {
            return
        }
        
        let cellData = arrayDataSource[indexPath.row]
        
        self.notificationViewModel?.declineAPI(paramDict: [Constants.Keys.kTempRatingID : cellData.ratingId ?? ""],completion: { (responseData, success) in
            
            self.arrayDataSource.removeAll()
            
            if success {
                
                self.getNotification(lastID: 0)
            }
        })
    }
    
}
