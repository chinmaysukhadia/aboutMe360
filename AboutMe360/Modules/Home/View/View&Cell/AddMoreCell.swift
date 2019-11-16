//
//  AddMoreCell.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 21/09/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import UIKit

class AddMoreCell: BaseTableViewCell {

    //MARK: - IBOUtlets

    @IBOutlet weak var addView: UIView!
    @IBOutlet weak var bgView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bgView.setViewShadow(color: UIColor.gray, cornerRadius: 8, shadowRadius: 2, shadowOpacity: 0.3)
        addView.roundCorners(8)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
