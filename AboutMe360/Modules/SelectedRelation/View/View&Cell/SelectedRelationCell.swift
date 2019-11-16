//
//  SelectedRelationCell.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 22/09/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import UIKit

class SelectedRelationCell: BaseTableViewCell {

    //MARK: - IBOUtlets

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bgView.setViewShadow(color: UIColor.gray, cornerRadius: 8, shadowRadius: 2, shadowOpacity: 0.3)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
