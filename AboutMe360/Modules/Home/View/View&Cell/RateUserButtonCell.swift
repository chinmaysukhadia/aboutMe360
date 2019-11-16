//
//  RateUserButtonCell.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 21/09/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import UIKit

class RateUserButtonCell: BaseTableViewCell {

    //MARK: - IBOUtlets

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bgView.roundCorners(8)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
