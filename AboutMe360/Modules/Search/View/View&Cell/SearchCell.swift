//
//  SearchCell.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 20/09/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import UIKit

class SearchCell: BaseTableViewCell {

    //MARK: - IBOUtlets
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var desinationLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratedIconImageView: UIImageView!

    
    //MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bgView.setViewShadow(color: UIColor.gray, cornerRadius: 10, shadowRadius: 2, shadowOpacity: 0.3)
        profileImageView.makeLayer(color: .lightText, boarderWidth: 2, round: 8.0)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - Public Methods
    
    func configureCell(cellData: SearchData) {
        nameLabel.text = cellData.name
        desinationLabel.text = cellData.designation
        let rating = Utilities.toDouble(cellData.rating)
        self.ratingLabel.text = rating > 0.0 ? String(format: "%.2f", rating) : StringConstants.threeDot

        if let url = cellData.profileImg {
            self.profileImageView.setImage(urlStr: url, placeHolderImage: UIImage(named: "Blank"))
        }
    }
    
}
