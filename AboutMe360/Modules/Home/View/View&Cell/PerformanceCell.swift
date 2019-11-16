//
//  PerformanceCell.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 21/09/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import UIKit

class PerformanceCell: BaseTableViewCell {
    
    //MARK: - IBOUtlets
    
    @IBOutlet var performanceView: UIView!
    @IBOutlet var leadershipView: UIView!
    @IBOutlet var interPersonalView: UIView!
    @IBOutlet var behaviouralView: UIView!
    @IBOutlet weak var performanceLabel: UILabel!
    @IBOutlet weak var leadershipLabel: UILabel!
    @IBOutlet weak var interLabel: UILabel!
    @IBOutlet weak var behaviouralLabel: UILabel!

    //MARK: - Life Cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        performanceView.roundCorners(12)
        leadershipView.roundCorners(12)
        interPersonalView.roundCorners(12)
        behaviouralView.roundCorners(12)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - Public Methods
    func configureCell(cellData: CellDetail) {
        
        performanceLabel.text = StringConstants.threeDot
        leadershipLabel.text = StringConstants.threeDot
        interLabel.text = StringConstants.threeDot
        behaviouralLabel.text = StringConstants.threeDot

        if let typeAvgRating = cellData.info?[kTypeAvgRating] as? [[String]]{
            
            if typeAvgRating.count > 0 {
                
              let typeAvg = typeAvgRating[0] as [String]
               if  typeAvg.count > 0 {
                    
                    let performanceRating = Utilities.toDouble(typeAvg[0])
                    self.performanceLabel.text = performanceRating > 0.0 ? String(format: "%.2f", performanceRating) : StringConstants.threeDot
                    
                    let leadershipRating = Utilities.toDouble(typeAvg[1])
                    self.leadershipLabel.text = leadershipRating > 0.0 ? String(format: "%.2f", leadershipRating) : StringConstants.threeDot
                    
                    let interRating = Utilities.toDouble(typeAvg[2])
                    self.interLabel.text = interRating > 0.0 ? String(format: "%.2f", interRating) : StringConstants.threeDot
                    
                    let behaviouralRating = Utilities.toDouble(typeAvg[3])
                    self.behaviouralLabel.text = behaviouralRating > 0.0 ? String(format: "%.2f", behaviouralRating) : StringConstants.threeDot
                }
            }
        }

    }
    
}
