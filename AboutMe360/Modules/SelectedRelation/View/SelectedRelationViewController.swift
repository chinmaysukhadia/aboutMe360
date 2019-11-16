//
//  SelectedRelationViewController.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 18/09/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import UIKit

class SelectedRelationViewController: BaseViewController {
    
    //MARK: - IBOUtlets
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var opinionLabel: UILabel!
    @IBOutlet weak var whoLabel: UILabel!
    @IBOutlet weak var topCircleView: UIView!
    
    //MARK: - Variables
    var arrayDataSource = ["My supervisor", "My subordinate", "My peer/stake-holder","None of the above"]
    var homeModel: HomeModel?
    var semiCircleLayer   = CAShapeLayer()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.setuUp()
    }
    
    //MARK: - Private Methods
    
    private func setuUp() {
        
        self.welcomeLabel.text = "Welcome " + Utilities.toString(object: homeModel?.homeData?.fullName)
        self.opinionLabel.text = "Give your honest opinion about " + Utilities.toString(object: homeModel?.homeData?.fullName)
        self.whoLabel.text = "Who is " + Utilities.toString(object: homeModel?.homeData?.fullName) + "?"
        
        // bgView.setViewShadow(color: UIColor.gray, cornerRadius: 0, shadowRadius: 5, shadowOpacity: 0.3)
        topView.roundCornersSide([.bottomRight], radius: 10)
        bgView.layer.masksToBounds = false
        bgView.layer.shadowColor = UIColor.gray.cgColor
        bgView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        bgView.layer.shadowRadius = 5
        bgView.layer.shadowOpacity = 0.3
        bgView.layer.cornerRadius = 10
        
        //Circle Points
        let center = CGPoint (x: topCircleView.frame.size.width / 2, y: topCircleView.frame.size.height / 2)
        let circleRadius = topCircleView.frame.size.width / 1.2
        let circlePath = UIBezierPath(arcCenter: center, radius: circleRadius, startAngle: CGFloat(0.0), endAngle: CGFloat(80), clockwise: true)
        semiCircleLayer.path = circlePath.cgPath
        if  let color = topCircleView.backgroundColor {
            semiCircleLayer.fillColor = color.cgColor
        }
        topCircleView.backgroundColor = .clear
        topCircleView.layer.addSublayer(semiCircleLayer)
        
        //        let circlePath = UIBezierPath.init(arcCenter: CGPointMake(button.bounds.size.width / 2, 0), radius: button.bounds.size.height, startAngle: 0.0, endAngle: CGFloat(M_PI), clockwise: true)
        //        let circleShape = CAShapeLayer()
        //        circleShape.path = circlePath.CGPath
        //        button.layer.mask = circleShape
        
        //        topCircleView.layer.mask = circleShape
        
        self.profilePicImageView.makeLayer(color: .white, boarderWidth: 3, round: 30)
        
        if let url = self.homeModel?.pimgBaseUrl, let profileIgm = self.homeModel?.homeData?.profileImg {
            self.profilePicImageView.setImage(urlStr: url+profileIgm, placeHolderImage: UIImage(named: "Blank"))
        }
        
        if let tabbarViewController = AppDelegate.delegate()?.window?.rootViewController as? TabbarViewController {
            tabbarViewController.showHideCenteredButton()
        }
        
        self.registerCell()
    }
    
    private func registerCell() {
        tableView.register(nibs: [SelectedRelationCell.className])
    }
    
    //MARK: - IBAction
    
    @IBAction func backButoonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}


extension SelectedRelationViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayDataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: SelectedRelationCell.className, for: indexPath) as? SelectedRelationCell {
            cell.selectionStyle = .none
            cell.backgroundColor = .clear
            cell.titleLabel.text = arrayDataSource[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let questionsVC = DIConfigurator.questionsViewController() as? QuestionsViewController  else {
            return
        }
        questionsVC.profileRate = .otherProfile
        questionsVC.catID = "\(indexPath.row+1)"
        questionsVC.ratedTo = homeModel?.homeData?.id
        self.navigationController?.pushViewController(questionsVC, animated: true)
    }
    
}
