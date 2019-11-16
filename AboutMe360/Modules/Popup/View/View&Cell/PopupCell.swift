//
//  PopupCell.swift
//  AboutMe360
//
//  Created by Narendra Kumar on 13/11/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import UIKit

class PopupCell: BaseTableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var radioImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - Public Methods
    func configureCell(cellData: String) {
        self.titleLabel.text = cellData
    }
    
}
