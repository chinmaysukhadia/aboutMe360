//
//  ShareCell.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 01/10/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import UIKit

protocol ShareCellDelegate: class {
    func didTapShareCell(cell: ShareCell)
}

class ShareCell: BaseTableViewCell {

    @IBOutlet weak var titleLabel: UILabel!

    var delegate: ShareCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - Public Methods
    func configureCell(cellData: CellDetail) {
        self.titleLabel.text = cellData.title
    }
    
    @IBAction func shareTapped(_ sender: Any) {
    
        if let delegate = delegate {
            delegate.didTapShareCell(cell: self)
        }
    }
    
}
