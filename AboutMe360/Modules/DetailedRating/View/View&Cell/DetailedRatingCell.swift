//
//  DetailedRatingCell.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 18/09/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import UIKit

class DetailedRatingCell: BaseTableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
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
    func configureCell(cellData: Supervisor) {
        self.titleLabel.text = cellData.quest
        let rating = Utilities.toDouble(cellData.rating)
        self.ratingLabel.text = rating > 0.0 ? String(format: "%.2f", rating) : StringConstants.threeDot
    }
}
