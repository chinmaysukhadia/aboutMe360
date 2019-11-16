//
//  OtherProfileViewModel.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 01/10/19.
//  Copyright © 2019 Appy. All rights reserved.
//


import Foundation
import SwiftyUserDefaults
import UIKit

class OtherProfileViewModel {
    
    func getAboutSectionDataSource(homeData: HomeData) -> [SectionCell] {
        
        var array = [SectionCell]()
        
        let headerCell = SectionCell(title: "Work Experience", subTitle: "", items: self.getExperienceDataSource(experience: homeData.experience))
        array.append(headerCell)
        let cell = SectionCell(title: "Highest Education", subTitle: "", items: self.getEducationCellDataSource(qualification: homeData.hQualification))
        array.append(cell)
        return array
    }
    
    
    func getExperienceDataSource(experience: [Experience]?) -> [CellDetail] {
        
        var array = [CellDetail]()
        
        if let expData = experience {
            for exp in expData {
                let cell = CellDetail (cellType: .experienceCell, title: "", subTitle: "", placeHolder: "", info: [kExperience:exp], height: UITableView.automaticDimension)
                array.append(cell)
            }
        }
        
        return array
    }
    
    func getEducationCellDataSource(qualification: [HQualification]?) -> [CellDetail] {
        
        var array = [CellDetail]()
        
        if let qualificationData = qualification {
            for exp in qualificationData {
                let cell = CellDetail (cellType: .educationCell, title: Utilities.toString(object: exp.qualification), subTitle: "", placeHolder: "", info: [kHqualification:exp], height: UITableView.automaticDimension)
                array.append(cell)
            }
        }
        
        return array
    }
    
    func getRatingSectionDataSource(homeData: HomeData) -> [SectionCell] {
        
        var array = [SectionCell]()
        
        let headerCell = SectionCell(title: "", subTitle: "", items: self.getRatingCellDataSource(homeData: homeData))
        array.append(headerCell)
        let cell = SectionCell(title: "", subTitle: "", items: self.getPerformanceCellDataSource(homeData: homeData))
        array.append(cell)
        
        if let topTraites = homeData.quesAvgRating {
            
            for index in 0...2 {
                
                let quesAvg  = topTraites[index]
                
                if quesAvg.count > 1 {
                    
                    if index == 0  {
                        
                        let rating = Utilities.toDouble(quesAvg[1])
                        
                        if rating > 0.0 {
                            
                            let yourTopTraitsCell = SectionCell(title: "Top 3 Strengths", subTitle: "", items: self.getTopTraitesCellCellDataSource(homeData: homeData))
                            array.append(yourTopTraitsCell)
                        }
                    }
                }
            }
        }
        
//        let yourTopTraitsCell = SectionCell(title: "Top 3 Strengths", subTitle: "", items: self.getTopTraitesCellCellDataSource(homeData: homeData))
//        array.append(yourTopTraitsCell)
        
        if homeData.alreadyRated != 1 {
            let ratingCell = SectionCell(title: "You can rate too!", subTitle: "", items: self.getButtonCellCellDataSource())
            array.append(ratingCell)
        }
        
        return array
    }
    
    func getRatingCellDataSource(homeData: HomeData) -> [CellDetail] {
        
        var array = [CellDetail]()
        let cell = CellDetail (cellType: .ratingProgressCell, title: "", subTitle: "", placeHolder: "", info: [kCatavgrating:homeData.catAvgRating as AnyObject], height: UITableView.automaticDimension)
        array.append(cell)
        return array
    }
    
    func getPerformanceCellDataSource(homeData: HomeData) -> [CellDetail] {
        
        var array = [CellDetail]()
        let cell = CellDetail (cellType: .performanceCell, title: "", subTitle: "", placeHolder: "", info: [kTypeAvgRating:homeData.typeAvgRating as AnyObject], height: UITableView.automaticDimension)
        array.append(cell)
        return array
    }
    
    func getTopTraitesCellCellDataSource(homeData: HomeData) -> [CellDetail] {
        
        var array = [CellDetail]()

        let cell = CellDetail (cellType: .topTraitesCell, title: "", subTitle: "", placeHolder: "", info: [kTopTraites:homeData.quesAvgRating as AnyObject], height: UITableView.automaticDimension)
        array.append(cell)
        
        return array
    }
    
    func getButtonCellCellDataSource() -> [CellDetail] {
        
        var array = [CellDetail]()
        let cell = CellDetail (cellType: .rateUserButtonCell, title: "", subTitle: "", placeHolder: "", info: [:], height: UITableView.automaticDimension)
        array.append(cell)
        return array
    }
}
