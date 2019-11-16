//
//  OtherProfileViewController+UITableView.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 01/10/19.
//  Copyright © 2019 Appy. All rights reserved.
//


import Foundation
import UIKit

extension OtherProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        return 50
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
    
    func getCell(tableView: UITableView, indexPath: IndexPath, cellData: CellDetail) -> UITableViewCell {
        guard let cellType = cellData.cellType else { return UITableViewCell()}
        switch cellType {
        
        case .educationCell:
            let cell: EducationCell = tableView.dequeueReusableCell(withIdentifier: EducationCell.className) as! EducationCell
            cell.selectionStyle = .none
            cell.editButton.isHidden = true
            cell.configureCell(cellData: cellData)
            return cell
        case .experienceCell:
            let cell: ExperienceCell = tableView.dequeueReusableCell(withIdentifier: ExperienceCell.className) as! ExperienceCell
            cell.selectionStyle = .none
            cell.editButton.isHidden = true
            cell.configureCell(cellData: cellData)
            return cell
        case .ratingProgressCell:
            let cell: RatingProgressCell = tableView.dequeueReusableCell(withIdentifier: RatingProgressCell.className) as! RatingProgressCell
            cell.selectionStyle = .none
            cell.statusView.isHidden = true
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
            
            if let alreadyRated = homeModel?.homeData?.alreadyRated, alreadyRated  > 0 {
                cell.bgView.backgroundColor = .lightGray
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if  let cellDetail = self.arrayAboutDataSource[indexPath.section].items?[indexPath.row] {
            
            guard let cellType = cellDetail.cellType else { return}
            switch cellType {
            case .rateUserButtonCell:
                
                if let alreadyRated = homeModel?.homeData?.alreadyRated, alreadyRated  > 0 {
                               return
                }
                
                guard let selectedRelationVC = DIConfigurator.selectedRelationViewController() as? SelectedRelationViewController  else {
                    return
                }
                selectedRelationVC.homeModel = self.homeModel
                self.navigationController?.pushViewController(selectedRelationVC, animated: true)
            default: break
            }
        }
    }
    
}
