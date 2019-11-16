//
//  RatingProgressCell.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 20/09/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import UIKit
import MBCircularProgressBar

protocol RatingProgressCellDelegate: class {
    func didTapRatingProgressCell(cell: RatingProgressCell,sender:Int)
}


class RatingProgressCell: BaseTableViewCell {

    @IBOutlet weak var supervisorProgressView: MBCircularProgressBarView!
    @IBOutlet weak var subordinatesProgressView: MBCircularProgressBarView!
    @IBOutlet weak var peersProgressView: MBCircularProgressBarView!
    @IBOutlet weak var otherProgressView: MBCircularProgressBarView!
    
    @IBOutlet weak var statusView: UIStackView!
    @IBOutlet weak var supervisorLabel: UILabel!
    @IBOutlet weak var subordinateLabel: UILabel!
    @IBOutlet weak var peersLabel: UILabel!
    @IBOutlet weak var otherLabel: UILabel!
    
    //
    @IBOutlet weak var supervisorButton: UIButton!
    @IBOutlet weak var subordinateButton: UIButton!
    @IBOutlet weak var peersButton: UIButton!
    @IBOutlet weak var otherButton: UIButton!
    
    var delegate: RatingProgressCellDelegate?
    let yourAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: color.appBlueColor,
    .underlineStyle: NSUnderlineStyle.single.rawValue]

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
        
     //   let rating = Utilities.toDouble(cellData.subTitle)
     //   self.rateLabel.text = rating >= 0.0 ? Utilities.toString(object: rating) : StringConstants.threeDot
        self.supervisorLabel.text = StringConstants.threeDot
        self.subordinateLabel.text = StringConstants.threeDot
        self.peersLabel.text = StringConstants.threeDot
        self.otherLabel.text = StringConstants.threeDot
        
       // supervisorButton.setTitle(StringConstants.view, for: .normal)
      //  subordinateButton.setTitle(StringConstants.view, for: .normal)
      //  peersButton.setTitle(StringConstants.view, for: .normal)
     //   otherButton.setTitle(StringConstants.view, for: .normal)
        
        let attributeString = NSMutableAttributedString(string: StringConstants.view,
                                                            attributes: yourAttributes)
        otherButton.setAttributedTitle(attributeString, for: .normal)
        supervisorButton.setAttributedTitle(attributeString, for: .normal)
        subordinateButton.setAttributedTitle(attributeString, for: .normal)
        peersButton.setAttributedTitle(attributeString, for: .normal)
        
        if let catavgRating = cellData.info?[kCatavgrating] as? [[String]]{
            
            if catavgRating.count > 0 {
                
                let typeAvg = catavgRating[0] as [String]
                if  typeAvg.count > 0 {
                    
                    let supervisorRating = Utilities.toDouble(typeAvg[0])
                    if supervisorRating > 0.0 {
                        self.supervisorLabel.text = String(format: "%.2f", supervisorRating)
                        supervisorProgressView.value = CGFloat(supervisorRating)
                    }
                    
                    let subordinateRating = Utilities.toDouble(typeAvg[1])
                    if subordinateRating > 0.0 {
                        self.subordinateLabel.text = String(format: "%.2f",subordinateRating)
                        subordinatesProgressView.value = CGFloat(subordinateRating)
                    }
                    
                    let peersRating = Utilities.toDouble(typeAvg[2])
                    if peersRating > 0.0 {
                        self.peersLabel.text = String(format: "%.2f",  peersRating)
                        peersProgressView.value = CGFloat(peersRating)
                    }
                    
                    let otherRating = Utilities.toDouble(typeAvg[3])
                    if otherRating > 0.0 {
                        self.otherLabel.text = String(format: "%.2f", otherRating)
                        otherProgressView.value = CGFloat(otherRating)
                    }
                }
            }
        }
    }
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        if let delegate = delegate {
            delegate.didTapRatingProgressCell(cell: self,sender: sender.tag)
        }
    }
}
