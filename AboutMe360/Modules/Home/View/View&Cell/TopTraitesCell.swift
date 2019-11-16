//
//  TopTraitesCell.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 21/09/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import UIKit

class TopTraitesCell: BaseTableViewCell {
    
    //MARK: - IBOUtlets
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var ratingIcon: UIImageView!
    
    @IBOutlet weak var titleLabel1: UILabel!
    @IBOutlet weak var rateLabel1: UILabel!
    @IBOutlet weak var ratingIcon1: UIImageView!
    
    @IBOutlet weak var titleLabel2: UILabel!
    @IBOutlet weak var rateLabel2: UILabel!
    @IBOutlet weak var ratingIcon2: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        bgView.setViewShadow(color: UIColor.gray, cornerRadius: 10, shadowRadius: 2, shadowOpacity: 0.3)
        // Configure the view for the selected state
    }
    
    //MARK: - Public Methods
    func configureCell(cellData: CellDetail, count: Int) {
        self.titleLabel.text = cellData.title
        let rating = Utilities.toDouble(cellData.subTitle)
        self.rateLabel.text = rating > 0.0 ? Utilities.toString(object: rating) : StringConstants.threeDot
        
        if let topTraites = cellData.info?[kTopTraites] as? [[String]]{
            
            for index in 0...2 {
                
                let quesAvg  = topTraites[index]
                
                if quesAvg.count > 1 {
                    if index == 0  {
                        self.titleLabel.text  = Utilities.toString(object: quesAvg[0])
                        let rating = Utilities.toDouble(quesAvg[1])
                        self.rateLabel.text = rating > 0.0 ? String(format: "%.2f", rating) : StringConstants.threeDot
                    } else if index == 1  {
                        self.titleLabel1.text  = Utilities.toString(object: quesAvg[0])
                        let rating = Utilities.toDouble(quesAvg[1])
                        self.rateLabel1.text = rating > 0.0 ? String(format: "%.2f", rating) : StringConstants.threeDot
                    }else  {
                        self.titleLabel2.text  = Utilities.toString(object: quesAvg[0])
                        let rating = Utilities.toDouble(quesAvg[1])
                        self.rateLabel2.text = rating > 0.0 ? String(format: "%.2f", rating) : StringConstants.threeDot
                    }
                }
            }
        }
        
    }
}
