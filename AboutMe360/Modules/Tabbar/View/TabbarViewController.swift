//
//  TabbarViewController.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 17/09/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class TabbarViewController: UITabBarController,UITabBarControllerDelegate {

    let shareButton = UIButton.init(type: .custom)
    let searchButton = UIButton.init(type: .custom)
    let searchView = UIView()
    let tempView = UIView()
    let tempView2 = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setuUp()
    }
    
    //MARK: - Private Methods
    
    private func setuUp() {
        
        shareButton.backgroundColor = .clear
        shareButton.addTarget(self, action: #selector(share), for: .touchUpInside)
        self.view.insertSubview(shareButton, aboveSubview: self.tabBar)
        
        searchButton.backgroundColor = .white
        searchButton.setImage(UIImage(named: "search"), for: .normal)
        
        searchButton.isUserInteractionEnabled = false
        searchView.isUserInteractionEnabled = false
        searchView.isUserInteractionEnabled = false
        tempView.isUserInteractionEnabled = false
        tempView2.isUserInteractionEnabled = false

        
        searchButton.frame = CGRect.init(x:5, y:5, width: 50, height: 50)
        searchButton.makeLayer(color: UIColor.white, boarderWidth: 0, round: 30)
        searchButton.layer.cornerRadius = searchButton.frame.size.width/2
        
        tempView.frame = CGRect.init(x:0, y:0, width: 60, height: 60)
        tempView.backgroundColor = .white
        
        tempView.layer.shadowOffset = CGSize(width: 0, height: -1)
        tempView.layer.shadowRadius = 2
        tempView.layer.shadowColor = UIColor.black.cgColor
        tempView.layer.shadowOpacity = 0.3
        tempView.layer.cornerRadius = 30
        
        tempView2.backgroundColor = .white
        tempView2.frame = CGRect.init(x:-5, y:20, width: 70, height: 70)

        searchView.addSubview(tempView)
        searchView.addSubview(tempView2)
        searchView.addSubview(searchButton)

        self.view.insertSubview(searchView, aboveSubview: self.tabBar)
        //
        self.tabBar.backgroundColor = .white
        tabBar.shadowImage = UIImage()
        tabBar.backgroundImage = UIImage()
        
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBar.layer.shadowRadius = 2
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.3
        
        self.tabBar.tintColor = color.appBlueColor
     
        UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0.0, vertical: -15.0)
        
        Defaults[.selectedIndex] = 0
        self.delegate = self

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
      //  self.tabBarItem.imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        
        self.tabBar.items?[0].imageInsets.top = -10
        self.tabBar.items?[1].imageInsets.top = -10
        self.tabBar.items?[3].imageInsets.top = -10
        self.tabBar.items?[4].imageInsets.top = -10

       // self.tabBar.items?[0].imageInsets.bottom = -10

        var safeAreaBottom: CGFloat = 0.0
        
        if #available(iOS 11.0, *) {
            if let window = UIApplication.shared.keyWindow {
                safeAreaBottom = window.safeAreaInsets.bottom
            }
        }
        
        let width = self.view.bounds.width/5
        shareButton.frame = CGRect.init(x: width, y: self.view.bounds.height-safeAreaBottom-CGFloat(TabbarHeight), width: width, height: safeAreaBottom+CGFloat(TabbarHeight))
        
        //
        searchView.frame = CGRect.init(x: self.tabBar.center.x - 30, y: self.view.bounds.height-safeAreaBottom-CGFloat(TabbarHeight)-20, width: 60, height: 60)
        self.view.bringSubviewToFront(searchView)
        self.view.bringSubviewToFront(shareButton)
        searchView.isHidden = false
        self.showHideCenteredButton()
        
    }

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
   
        if tabBarController.selectedIndex != 2 {
            Defaults[.selectedIndex] = tabBarController.selectedIndex
        }
    }
    
    func showHideCenteredButton() {
        
        searchView.isHidden = false
        
        if let navVC = self.viewControllers?[0] as? UINavigationController {
            
            for obj in navVC.viewControllers{
                
                if obj.isKind(of: QuestionsViewController.self) || obj.isKind(of: SelectedRelationViewController.self) || obj.isKind(of: OtherProfileViewController.self) {
                    searchView.isHidden = true
                }
            }
        }
        
        if let navVC = self.viewControllers?[2] as? UINavigationController {
            
            for obj in navVC.viewControllers{
                
                if obj.isKind(of: QuestionsViewController.self) || obj.isKind(of: SelectedRelationViewController.self) || obj.isKind(of: OtherProfileViewController.self) {
                    searchView.isHidden = true
                }
            }
        }
        
    }
    
    @objc func share() {
        
        // text to share
        let text = "Hi\nhttps://www.google.com"
        // set up activity view controller
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }

}
