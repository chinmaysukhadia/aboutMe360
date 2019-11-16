//
//  NotificationCell.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 17/09/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import UIKit


protocol NotificationCellDelegate: class {
    func didTapAcceptNotificationCell(cell: NotificationCell)
    func didTapDeclinNotificationCell(cell: NotificationCell)
}

class NotificationCell: BaseTableViewCell {
    
    //MARK: - IBOUtlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratedLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var declineButton: UIButton!
    @IBOutlet weak var buttonView : UIView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    
    var delegate: NotificationCellDelegate?

    //MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        bgView.roundCorners(10)
        profileImageView.roundCorners(4)
        bgView.setViewShadow(color: UIColor.gray, cornerRadius: 10, shadowRadius: 2, shadowOpacity: 0.3)
        declineButton.roundCorners(10)
        acceptButton.roundCorners(10)
        declineButton.makeLayer(color: .red, boarderWidth: 1, round: 10)
        // Configure the view for the selected state
    }
    
    //MARK: - Public Methods
    func configureCell(cellData: NotifiData) {
        
        nameLabel.text = cellData.name
        if let profileIgm = cellData.pimg {
            self.profileImageView.setImage(urlStr:profileIgm, placeHolderImage: UIImage(named: "Blank"))
        }
        
        if cellData.isAcceptable == false {
            self.buttonView.isHidden = true
            self.statusLabel.isHidden = true
        } else {
            
            if cellData.status == "1" {
                self.buttonView.isHidden = true
                self.statusLabel.isHidden = false
                self.statusLabel.text = StringConstants.accepted
                self.statusLabel.textColor = color.appBlueColor
            } else if cellData.status == "2" {
                 self.buttonView.isHidden = true
                 self.statusLabel.isHidden = false
                 self.statusLabel.textColor = UIColor.red
                 self.statusLabel.text = StringConstants.declined
            } else {
                 self.buttonView.isHidden = false
                 self.statusLabel.isHidden = true
            }
        }
    }
    
    @IBAction func acceptTapped(_ sender: Any) {
        if let delegate = delegate {
            delegate.didTapAcceptNotificationCell(cell: self)
        }
    }
    
    @IBAction func decineTapped(_ sender: Any) {
        
        if let delegate = delegate {
            delegate.didTapDeclinNotificationCell(cell: self)
        }
    }
}
