//
//  HomeViewController+UITableView.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 20/09/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import Foundation
import UIKit
import SwiftyUserDefaults

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.arrayAboutDataSource.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let cell: HeaderCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as! HeaderCell
        cell.selectionStyle = .none
        cell.configureView(title: self.arrayAboutDataSource[section].title)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if let title = self.arrayAboutDataSource[section].title?.trim(), title.isEmpty {
            return 0
        }
        return 35
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrayAboutDataSource[section].items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if  let cellDetail = self.arrayAboutDataSource[indexPath.section].items?[indexPath.row] {
            return self.getCell(tableView: tableView, indexPath: indexPath, cellData: cellDetail)
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.didSelectCell(indexPath: indexPath)
    }
    
    func getCell(tableView: UITableView, indexPath: IndexPath, cellData: CellDetail) -> UITableViewCell {
        guard let cellType = cellData.cellType else { return UITableViewCell()}
        switch cellType {
        case .addMoreCell:
            let cell: AddMoreCell = tableView.dequeueReusableCell(withIdentifier: AddMoreCell.className) as! AddMoreCell
            cell.selectionStyle = .none
            return cell
        case .educationCell:
            let cell: EducationCell = tableView.dequeueReusableCell(withIdentifier: EducationCell.className) as! EducationCell
            cell.selectionStyle = .none
            cell.delegate = self
            cell.configureCell(cellData: cellData)
            return cell
        case .experienceCell:
            let cell: ExperienceCell = tableView.dequeueReusableCell(withIdentifier: ExperienceCell.className) as! ExperienceCell
            cell.selectionStyle = .none
            cell.delegate =  self
            cell.configureCell(cellData: cellData)
            return cell
        case .ratingProgressCell:
            let cell: RatingProgressCell = tableView.dequeueReusableCell(withIdentifier: RatingProgressCell.className) as! RatingProgressCell
            cell.selectionStyle = .none
            cell.delegate = self
            cell.configureCell(cellData: cellData)
            return cell
        case .performanceCell:
            let cell: PerformanceCell = tableView.dequeueReusableCell(withIdentifier: PerformanceCell.className) as! PerformanceCell
            cell.selectionStyle = .none
            cell.configureCell(cellData: cellData)
            return cell
        case .topTraitesCell:
            let cell: TopTraitesCell = tableView.dequeueReusableCell(withIdentifier: TopTraitesCell.className) as! TopTraitesCell
            cell.selectionStyle = .none
            cell.configureCell(cellData: cellData, count: indexPath.row)
            return cell
        case .rateUserButtonCell:
            let cell: RateUserButtonCell = tableView.dequeueReusableCell(withIdentifier: RateUserButtonCell.className) as! RateUserButtonCell
            cell.selectionStyle = .none
            cell.bgView.backgroundColor = .white
            cell.bgView.makeLayer(color: color.appBlueColor, boarderWidth: 2, round: 8.0)
            cell.titleLabel.textColor = color.appBlueColor
            cell.titleLabel.text = StringConstants.rateYourself
            return cell
        case .shareCell:
            let cell: ShareCell = tableView.dequeueReusableCell(withIdentifier: ShareCell.className) as! ShareCell
            cell.selectionStyle = .none
            cell.delegate = self
            cell.configureCell(cellData: cellData)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func didSelectCell(indexPath: IndexPath) {
        
        if  let cellDetail = self.arrayAboutDataSource[indexPath.section].items?[indexPath.row] {
            
            guard let cellType = cellDetail.cellType else { return}
            switch cellType {
            case .addMoreCell:
                
                guard let profileVC = DIConfigurator.profileViewController() as? ProfileViewController  else {
                    return
                }
                profileVC.signType = .addNew
                profileVC.callBack = {
                    
                    self.loginViewModel?.profileAPI(authDict: nil, param: [Constants.Keys.kUserID: "" as AnyObject],completion: { (data, success) in
                        
                        if success {
                            Defaults[.profleData] = data as? HomeModel
                            Threads.performTaskInMainQueue {
                                 self.setupDataSource()
                                 self.setupAboutDataSource()
                            }
                        }
                    })
                }
                
                self.navigationController?.pushViewController(profileVC, animated: true)
                break
                
            case .educationCell:
                
                guard let editHeighestQualificationVC = DIConfigurator.editHeighestQualificationViewController() as? EditHeighestQualificationViewController  else {
                    return
                }
                
                if let hQualification = cellDetail.info?[kHqualification] as? HQualification {
                    editHeighestQualificationVC.hQualification = hQualification
                }
                editHeighestQualificationVC.callBack = {
                    
                    self.loginViewModel?.profileAPI(authDict: nil, param: [Constants.Keys.kUserID: "" as AnyObject],completion: { (data, success) in
                        
                        if success {
                            Defaults[.profleData] = data as? HomeModel
                            
                            Threads.performTaskInMainQueue {
                                 self.setupDataSource()
                                 self.setupAboutDataSource()
                            }
                        }
                    })
                }
                
                self.navigationController?.pushViewController(editHeighestQualificationVC, animated: true)
                
                break
                
            case .experienceCell:
                
                guard let profileVC = DIConfigurator.profileViewController() as? ProfileViewController  else {
                    return
                }
                profileVC.signType = .edit
                
                if let expcount = Defaults[.profleData]?.homeData?.experience?.count, expcount > 0 {
                    profileVC.isDelete = true
                }
                
                if let experience = cellDetail.info?[kExperience] as? Experience {
                    profileVC.experience = experience
                }
                profileVC.callBack = {
                    
                    self.loginViewModel?.profileAPI(authDict: nil, param: [Constants.Keys.kUserID: "" as AnyObject],completion: { (data, success) in
                        
                        if success {
                            self.setupDataSource()
                        }
                    })
                }
                
                self.navigationController?.pushViewController(profileVC, animated: true)
                
            case .rateUserButtonCell:
                
                guard let questionsVC = DIConfigurator.questionsViewController() as? QuestionsViewController  else {
                    return
                }
                questionsVC.profileRate = .selfProfile
                self.navigationController?.pushViewController(questionsVC, animated: true)
            default: break
            }
        }
    }
    
    
}

extension HomeViewController: ShareCellDelegate {
    
    func didTapShareCell(cell: ShareCell) {
        guard let indexPath = self.homeTableView.indexPath(for: cell) else {
                   return
               }
        if let cellDetail = self.arrayAboutDataSource[indexPath.section].items?[indexPath.row]{
            self.share(url: cellDetail.title)
        }
    }
    
}

extension HomeViewController: EducationCellDelegate {
    
    func didTapEducationCell(cell: EducationCell) {
        guard let indexPath = self.homeTableView.indexPath(for: cell) else {
            return
        }
        self.didSelectCell(indexPath: indexPath)
    }
    
}

extension HomeViewController: ExperienceCellDelegate {
    func didTapExperienceCell(cell: ExperienceCell) {
        guard let indexPath = self.homeTableView.indexPath(for: cell) else {
            return
        }
        self.didSelectCell(indexPath: indexPath)
    }
    
}

extension HomeViewController: RatingProgressCellDelegate {
    
    func didTapRatingProgressCell(cell: RatingProgressCell, sender: Int) {
        guard let indexPath = self.homeTableView.indexPath(for: cell) else {
            return
        }
        
        let totalRating = Utilities.toDouble(self.homeModel?.homeData?.totalRatingCount)
        
        if totalRating > 2 {
            
            if  let cellDetail = self.arrayAboutDataSource[indexPath.section].items?[indexPath.row] {
                
                if let catavgRating = cellDetail.info?[kCatavgrating] as? [[String]]{
                    
                    if catavgRating.count > 0 {
                        
                        let typeAvg = catavgRating[0] as [String]
                        if  typeAvg.count > 0 {
                            
                            let rating = Utilities.toDouble(typeAvg[sender-1])
                            if rating > 0.0 {
                                
                                switch sender {
                                case 1:
                                    self.detailRating(type: .supervisor)
                                case 2:
                                    self.detailRating(type: .subordinates)
                                case 3:
                                    self.detailRating(type: .peers)
                                case 4:
                                    self.detailRating(type: .other)
                                default:
                                    break
                                }
                            }
//                            else {
//                                self.minRatingPopup()
//                            }
                            
                        }
                    }
                }
            }
            
        } else {
             self.minRatingPopup()
        }
        
    }
}



