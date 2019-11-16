//
//  EducationCell.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 21/09/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import UIKit

protocol EducationCellDelegate: class {
    func didTapEducationCell(cell: EducationCell)
}

class EducationCell: BaseTableViewCell {

    //MARK: - IBOUtlets

    @IBOutlet weak var iconView: UIView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    
    var delegate: EducationCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bgView.setViewShadow(color: UIColor.gray, cornerRadius: 8, shadowRadius: 2, shadowOpacity: 0.3)
        iconView.roundCorners(8)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - Public Methods
    func configureCell(cellData: CellDetail) {
        self.titleLabel.text = cellData.title
    }
    
    @IBAction func editTapped(_ sender: UIButton) {
        if let delegate = delegate {
            delegate.didTapEducationCell(cell: self)
        }
    }
    
}
