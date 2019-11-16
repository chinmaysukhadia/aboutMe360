//
//  QuestionsCell.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 18/09/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import UIKit

protocol QuestionsCellDelegate: class {
    func didTapQuestionsCell(cell: QuestionsCell, rating:Int)
}

class QuestionsCell: BaseTableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var transparentImageView: UIImageView!
    @IBOutlet weak var ratingButton1: UIButton!
    @IBOutlet weak var ratingButton2: UIButton!
    @IBOutlet weak var ratingButton3: UIButton!
    @IBOutlet weak var ratingButton4: UIButton!
    @IBOutlet weak var ratingButton5: UIButton!
    
    var delegate: QuestionsCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       // bgView.setViewShadow(color: UIColor.gray, cornerRadius: 8, shadowRadius: 5, shadowOpacity: 1.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - Public Methods
    func configureCell(cellData: QuestionsDataModel) {
        self.titleLabel.attributedText = cellData.title
        self.buttonTapped(tag: cellData.rating)
    }
    
    @IBAction func ratingTapped(_ sender: UIButton) {
        if let delegate = delegate {
            delegate.didTapQuestionsCell(cell: self,rating: sender.tag)
        }
        
        self.buttonTapped(tag: sender.tag)
    }
    
    func buttonTapped(tag: Int)  {
        
        self.ratingButton1.isSelected = false
        self.ratingButton2.isSelected = false
        self.ratingButton3.isSelected = false
        self.ratingButton4.isSelected = false
        self.ratingButton5.isSelected = false

        switch tag {
        case 1:
            self.ratingButton1.isSelected = true
        case 2:
            self.ratingButton1.isSelected = true
            self.ratingButton2.isSelected = true
        case 3:
            self.ratingButton1.isSelected = true
            self.ratingButton2.isSelected = true
            self.ratingButton3.isSelected = true
        case 4:
            self.ratingButton1.isSelected = true
            self.ratingButton2.isSelected = true
            self.ratingButton3.isSelected = true
            self.ratingButton4.isSelected = true
        case 5:
            self.ratingButton1.isSelected = true
            self.ratingButton2.isSelected = true
            self.ratingButton3.isSelected = true
            self.ratingButton4.isSelected = true
            self.ratingButton5.isSelected = true
        default:
            break
        }        
    }
}
