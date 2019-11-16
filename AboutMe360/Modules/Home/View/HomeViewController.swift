//
//  HomeViewController.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 17/09/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class HomeViewController: BaseViewController {
    
    //MARK: - IBOUtlets
    
    @IBOutlet var ratingSelectedView: UIView!
    @IBOutlet var aboutSelectedView: UIView!
    @IBOutlet var ratingButton: UIButton!
    @IBOutlet var aboutButton: UIButton!
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var homeTableView: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var designationLabel: UILabel!
    @IBOutlet weak var educationLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var totalRatingLabel: UILabel!
    @IBOutlet weak var profileStatusLabel: UILabel!
    @IBOutlet var topBgView: UIView!
    
    //MARK: - Variables
    
    var homeModel: HomeModel?
    var arrayAboutDataSource = [SectionCell]()
    var viewModel: HomeViewModel?
    var loginViewModel: LoginViewModel?
    let yourAttributes: [NSAttributedString.Key: Any] = [
        .underlineStyle: NSUnderlineStyle.single.rawValue]
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.setuUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setupDataSource()
    }
    
    //MARK: - Private Methods
    
    private func setuUp() {
        self.registerCell()
        self.setupViewModel()
        self.setupDataSource()
        self.setupRatingDataSource()
        self.buttonSelected(sender: self.ratingButton)
        profileImageView.makeLayer(color: .lightText, boarderWidth: 2, round: 10.0)
        topBgView.roundCornersSide([.bottomRight], radius: 12)
        
        self.getProfileData()
    }
    
    private func registerCell() {
        homeTableView.register(nibs: [RatingProgressCell.className,PerformanceCell.className,TopTraitesCell.className,HeaderCell.className,AddMoreCell.className,ExperienceCell.className,EducationCell.className,RateUserButtonCell.className,ShareCell.className])
    }
    
    private func buttonSelected(sender:UIButton) {
        
        self.ratingButton.isSelected = false
        self.aboutButton.isSelected = false
        // self.aboutButton.setTitleColor(color.appBlueColor, for: .normal)
        //  self.ratingButton.setTitleColor(color.appBlueColor, for: .normal)
        sender.isSelected = true
        //   sender.setTitleColor(color.appDarkBlueColor, for: .normal)
        ratingSelectedView.isHidden = !self.ratingButton.isSelected
        aboutSelectedView.isHidden = !self.aboutButton.isSelected
    }
    
    // Set data model view
    private func setupViewModel() {
        viewModel = HomeViewModel()
        loginViewModel = LoginViewModel()
    }
    
    func renderUI() {
        
        if Defaults[.profleData] == nil {
            return
        }
        
        self.educationLabel.text = ""
        self.designationLabel.text = ""
        
        self.homeModel = Defaults[.profleData]
        self.nameLabel.text =  self.homeModel?.homeData?.fullName
        
        if let experience = self.homeModel?.homeData?.experience, experience.count > 0 {
            self.designationLabel.text =  experience[0].designation
        }
        
        if let hQualification = self.homeModel?.homeData?.hQualification, hQualification.count > 0 {
            self.educationLabel.text =  hQualification[0].qualification
        }
        
        // self.designationLabel.text =  self.homeModel?.homeData?.ex
        
        Defaults[.name] = self.homeModel?.homeData?.fullName
        if let url = self.homeModel?.pimgBaseUrl, let profileIgm = self.homeModel?.homeData?.profileImg {
            self.profileImageView.setImage(urlStr: url+profileIgm, placeHolderImage: UIImage(named: "Blank"))
        }
        
        //
        
        let rating = Utilities.toDouble(self.homeModel?.homeData?.totalAvgRating)
        self.ratingLabel.text = rating > 0.0 ? String(format: "%.2f", rating) : StringConstants.threeDot
        
        //
        let totalRating = Utilities.toInt(self.homeModel?.homeData?.totalRatingCount)
        
        // otherButton.setAttributedTitle(attributeString, for: .normal)
        var totalRatingString  = ""
        if totalRating == 0 {
            totalRatingString = "No Ratings"
        } else {
            
            var outOff = 0
            
            if totalRating > 2 {
                
                if totalRating % 3 == 0 {
                    print("Number is even")
                    outOff = totalRating
                } else {
                    outOff = totalRating/3
                    outOff = outOff*3
                }
            }
            
            totalRatingString = Utilities.toString(object: outOff) + " of " + Utilities.toString(object: totalRating) + " Ratings"
        }
        
        let attributeString = NSMutableAttributedString(string: totalRatingString,
                                                        attributes: yourAttributes)
        self.totalRatingLabel.attributedText = attributeString
        
        self.profileStatusLabel.text = self.homeModel?.homeData?.profileType == "0" ? StringConstants.ratingOpenAll : StringConstants.ratingInviteesOnly
        
    }
    
    // Set data Source
    func setupDataSource() {
        
        self.renderUI()
    }
    
    func setupAboutDataSource() {
        
        if let homeData = Defaults[.profleData]?.homeData {
            
            if let dataSource = self.viewModel?.getAboutSectionDataSource(homeData: homeData) {
                self.arrayAboutDataSource.removeAll()
                self.arrayAboutDataSource.append(contentsOf: dataSource)
                Threads.performTaskInMainQueue {
                    self.homeTableView.reloadData()
                }
            }
        }
    }
    
    func setupRatingDataSource() {
        
        if let homeData = Defaults[.profleData]?.homeData {
            
            if let dataSource = self.viewModel?.getRatingSectionDataSource(homeData: homeData) {
                self.arrayAboutDataSource.removeAll()
                self.arrayAboutDataSource.append(contentsOf: dataSource)
                Threads.performTaskInMainQueue {
                    self.homeTableView.reloadData()
                }
            }
        }
    }
    
    func getProfileData() {
        
        let loginViewModel:LoginViewModel = LoginViewModel()
        loginViewModel.profileAPI(authDict: nil, param: [Constants.Keys.kUserID: "" as AnyObject],completion: { (data, success) in
            
            if success {
                Defaults[.profleData] = data as? HomeModel
                self.setupDataSource()
            }
        })
    }
    
    func detailRating(type: DetailedRatingType) {
        
        guard let detailedRatingVC = DIConfigurator.detailedRatingViewController() as? DetailedRatingViewController  else {
            return
        }
        detailedRatingVC.detailedRatingType = type
        detailedRatingVC.homeModel = self.homeModel
        detailedRatingVC.modalPresentationStyle = .overCurrentContext
        self.navigationController?.present(detailedRatingVC, animated: false, completion: nil)
    }
    
    func minRatingPopup() {
        
        guard let minRatingPopupVC = DIConfigurator.minRatingPopupViewController() as? MinRatingPopupViewController  else {
            return
        }
        minRatingPopupVC.modalPresentationStyle = .overCurrentContext
        self.navigationController?.present(minRatingPopupVC, animated: false, completion: nil)
    }
    
    func share(url:String) {
        
        // text to share
        let text = "Rate me on AboutMe360 at\n" + url
        // set up activity view controller
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    //MARK: - IBAction
    
    @IBAction func allButtonTapped(_ sender: Any) {
        
        let totalRating = Utilities.toDouble(self.homeModel?.homeData?.totalRatingCount)
        
        if totalRating == 0 {
            self.minRatingPopup()
        } else {
            self.detailRating(type: .all)
        }
    }
    
    @IBAction func ratingButtonTapped(_ sender: Any) {
        self.buttonSelected(sender: self.ratingButton)
        self.setupRatingDataSource()
    }
    
    @IBAction func aboutButtonTapped(_ sender: Any) {
        self.buttonSelected(sender: self.aboutButton)
        self.setupAboutDataSource()
    }
    
    @IBAction func editProfileButtonTapped(_ sender: Any) {
        guard let editProfileVC = DIConfigurator.editProfileViewController() as? EditProfileViewController  else {
            return
        }
        editProfileVC.callBack = {
            self.getProfileData()
        }
        self.navigationController?.pushViewController(editProfileVC, animated: true)
    }
    
}
