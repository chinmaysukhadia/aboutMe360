//
//  ExperienceCell.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 21/09/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import UIKit

protocol ExperienceCellDelegate: class {
    func didTapExperienceCell(cell: ExperienceCell)
}

class ExperienceCell: BaseTableViewCell {

    //MARK: - IBOUtlets
    
    @IBOutlet weak var iconView: UIView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var designationLabel: UILabel!
    @IBOutlet weak var orgNameLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    
    var delegate: ExperienceCellDelegate?

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
        
        if let experience = cellData.info?[kExperience] as? Experience {
            designationLabel.text = experience.designation ?? ""
            let industry = experience.industry ?? ""
            let workLocation = experience.workLocation ?? ""
            let jobProfile = experience.jobProfile ?? ""
            let orgName = experience.orgName ?? ""
            orgNameLabel.text = orgName + "," + workLocation + "\n" + industry + "-" + jobProfile
            
            if experience.currentlyWorking == "1" {
                let dateString = Utilities.toString(object: experience.duration).components(separatedBy: ",")
                if dateString.count > 0 {
                    
                    let year = dateString[0].components(separatedBy: "/")
                    if year.count > 2 {
                        durationLabel.text = year[2] + " - " + "Present"
                    }
                }
            } else {
                durationLabel.text = Utilities.toString(object: experience.duration).replacingOccurrences(of: ",", with: " - ")
            }
        }
    }
    
    @IBAction func editTapped(_ sender: UIButton) {
        if let delegate = delegate {
            delegate.didTapExperienceCell(cell: self)
        }
    }
    
}
