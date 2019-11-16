//
//  CompanyCell.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 20/09/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import UIKit

class CompanyCell: BaseTableViewCell {

    //MARK: - IBOUtlets

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var titleLabel: UILabel!

    //MARK: - Life Cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bgView.makeLayer(color: .lightGray, boarderWidth: 1, round: 0.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    //MARK: - Public Methods
    
    func configureCell(cellData: OrgName) {
        titleLabel.text = cellData.name
    }
    
}
