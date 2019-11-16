//
//  BaseTableViewCell.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 9/11/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


struct CellDetail {
    
    var cellType: CellType!
    var title: String
    var subTitle: String
    var placeHolder: String!
    var height: CGFloat!
    var info: [String : AnyObject]?
    
    init(cellType: CellType, title: String = "", subTitle: String = "", placeHolder: String = "",info:[String : AnyObject]? = nil, height: CGFloat = UITableView.automaticDimension) {
        self.cellType = cellType
        self.title = title
        self.subTitle = subTitle
        self.placeHolder = placeHolder
        self.height = height
        self.info = info
    }
}

struct SectionCell {
    var title: String?
    var subTitle: String
    var items:[CellDetail]?
    init(title: String = "",subTitle: String = "",items:[CellDetail]?) {
        self.title = title
        self.subTitle = subTitle
        self.items = items
    }
}

enum CellType {
    
    case headerCell
    case addMoreCell
    case experienceCell
    case educationCell
    case ratingProgressCell
    case performanceCell
    case topTraitesCell
    case rateUserButtonCell
    case shareCell

    
}
