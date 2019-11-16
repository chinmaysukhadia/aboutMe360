//
//  OtherProfileViewController.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 01/10/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class OtherProfileViewController: BaseViewController {
    
    //MARK: - IBOUtlets
    
    @IBOutlet var tableViewHeader: UIView!
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
    var viewModel: OtherProfileViewModel?
    var loginViewModel: LoginViewModel?
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.setuUp()
    }
    
    //MARK: - Private Methods
    
    private func setuUp() {
        self.setupViewModel()
        self.setupDataSource()
        self.setupRatingDataSource()
        self.buttonSelected(sender: self.ratingButton)
        profileImageView.makeLayer(color: .lightText, boarderWidth: 2, round: 10.0)
        topBgView.roundCornersSide([.bottomRight], radius: 12)
        self.registerCell()
        if let tabbarViewController = AppDelegate.delegate()?.window?.rootViewController as? TabbarViewController {
            tabbarViewController.showHideCenteredButton()
        }
    }
    
    private func registerCell() {
        homeTableView.register(nibs: [RatingProgressCell.className,PerformanceCell.className,TopTraitesCell.className,HeaderCell.className,AddMoreCell.className,ExperienceCell.className,EducationCell.className,RateUserButtonCell.className])
    }
    
    private func buttonSelected(sender:UIButton) {
        
        self.ratingButton.isSelected = false
        self.aboutButton.isSelected = false
//        self.aboutButton.setTitleColor(color.appBlueColor, for: .normal)
//        self.ratingButton.setTitleColor(color.appBlueColor, for: .normal)
        sender.isSelected = true
 //       sender.setTitleColor(color.appDarkBlueColor, for: .normal)
        ratingSelectedView.isHidden = !self.ratingButton.isSelected
        aboutSelectedView.isHidden = !self.aboutButton.isSelected
    }
    
    // Set data model view
    private func setupViewModel() {
        viewModel = OtherProfileViewModel()
        loginViewModel = LoginViewModel()
    }
    
    func renderUI() {
        
        self.educationLabel.text = ""
        self.designationLabel.text = ""
        
        self.nameLabel.text =  self.homeModel?.homeData?.fullName
        
        if let experience = self.homeModel?.homeData?.experience, experience.count > 0 {
            self.designationLabel.text =  experience[0].designation
        }
        
        if let hQualification = self.homeModel?.homeData?.hQualification, hQualification.count > 0 {
            self.educationLabel.text =  hQualification[0].qualification
        }
        
        // self.designationLabel.text =  self.homeModel?.homeData?.ex
        
        if let url = self.homeModel?.pimgBaseUrl, let profileIgm = self.homeModel?.homeData?.profileImg {
            self.profileImageView.setImage(urlStr: url+profileIgm, placeHolderImage: UIImage(named: "Blank"))
        }
        
        //
        
        let rating = Utilities.toDouble(self.homeModel?.homeData?.totalAvgRating)
        self.ratingLabel.text = rating > 0.0 ? String(format: "%.2f", rating) : StringConstants.threeDot

        let totalRating = Utilities.toInt(self.homeModel?.homeData?.totalRatingCount)
        
        //
      //  self.totalRatingLabel.text = "of " + Utilities.toString(object: totalRating) + " Ratings"
        
        var totalRatingString  = ""
        if totalRating == 0 {
            totalRatingString = "No Rating"
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
        
        self.totalRatingLabel.text = totalRatingString
        self.profileStatusLabel.text = self.homeModel?.homeData?.profileStatus == "1" ? StringConstants.ratingOpenAll : StringConstants.ratingInviteesOnly
        
    }
    
    // Set data Source
    func setupDataSource() {
        
        self.renderUI()
    }
    
    func setupAboutDataSource() {
        
        if let homeData = homeModel?.homeData {
            
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
        
        if let homeData = homeModel?.homeData {
            
            if let dataSource = self.viewModel?.getRatingSectionDataSource(homeData: homeData) {
                self.arrayAboutDataSource.removeAll()
                self.arrayAboutDataSource.append(contentsOf: dataSource)
                Threads.performTaskInMainQueue {
                    self.homeTableView.reloadData()
                }
            }
        }
    }
    
    //MARK: - IBAction
    
    @IBAction func ratingButtonTapped(_ sender: Any) {
        self.buttonSelected(sender: self.ratingButton)
        self.setupRatingDataSource()
    }
    
    @IBAction func aboutButtonTapped(_ sender: Any) {
        self.buttonSelected(sender: self.aboutButton)
        self.setupAboutDataSource()
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
