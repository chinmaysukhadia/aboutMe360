//
//  DetailedRatingViewController.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 18/09/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import UIKit

enum DetailedRatingType {
    
    case none
    case supervisor
    case subordinates
    case peers
    case other
    case all
}

class DetailedRatingViewController: BaseViewController {
    
    //MARK: - IBOUtlets
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var detailedRatingTableView: UITableView!
    @IBOutlet weak var totalRatingLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    //MARK: - Variables
    
    var detailedRatingType : DetailedRatingType = .none
    var homeModel: HomeModel?
    var arrayDataSource = [Supervisor]()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.setuUp()
    }
    
    //MARK: - Private Methods
    
    private func setuUp() {
        self.contentView.roundCorners(8)
        self.setupDataSource()
        self.registerCell()
        let rating = Utilities.toDouble(self.homeModel?.homeData?.totalAvgRating)
        self.ratingLabel.text = rating > 0.0 ? Utilities.toString(object: rating) : StringConstants.threeDot
        let totalRating = Utilities.toDouble(self.homeModel?.homeData?.totalRatingCount)
        self.totalRatingLabel.text = "of " + Utilities.toString(object: totalRating) + " Ratings"
    }
    
    private func setupDataSource() {
        
        switch detailedRatingType {
        case .supervisor:
            if let  supervisor = homeModel?.homeData?.supervisor  {
                arrayDataSource = supervisor
            }
        case .subordinates:
            if let  subordinate = homeModel?.homeData?.subordinate  {
                arrayDataSource = subordinate
            }
        case .peers:
            if let  peer = homeModel?.homeData?.peer  {
                arrayDataSource = peer
            }
        case .other:
            if let  other = homeModel?.homeData?.other  {
                arrayDataSource = other
            }
        case .all:
            if let  totalAvg = homeModel?.homeData?.totalAvg  {
                arrayDataSource = totalAvg
            }
        default:
            break
        }
    }
    
    private func registerCell() {
        detailedRatingTableView.register(nibs: [DetailedRatingCell.className])
    }
    
    //MARK: - IBAction
    
    @IBAction func crossButoonTapped(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func editButoonTapped(_ sender: Any) {
        
    }
    
}

extension DetailedRatingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayDataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: DetailedRatingCell.className, for: indexPath) as? DetailedRatingCell {
            cell.selectionStyle = .none
            cell.backgroundColor = .clear
            cell.configureCell(cellData: arrayDataSource[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
}
