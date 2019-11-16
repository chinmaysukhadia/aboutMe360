//
//  Alert.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 26/09/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import Foundation
import UIKit

class Alert {
    //Logout Alert
    class func showAlertWithActionWithColor(title: String?, message: String?, actionTitle: String?, showCancel:Bool,_ viewC: UIViewController? = nil, completion: @escaping (_ tag: Int) -> Void) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if showCancel {
            alertController.addAction(UIAlertAction.init(title: "Cancel", style: UIAlertAction.Style.default, handler: { (action : UIAlertAction) in
                completion(0)
            }))
        }
        
        alertController.addAction(UIAlertAction.init(title: actionTitle, style: UIAlertAction.Style.default, handler: { (action : UIAlertAction) in
            completion(1)
        }))
        
        if let viewController = viewC {
            viewController.present(alertController, animated: true, completion: nil)
        } else {
            let topViewController: UIViewController? = self.topMostViewController(rootViewController: self.rootViewController())
            topViewController?.present(alertController, animated: true, completion: nil)
        }
    }
        
        // MARK: - Get topmost view controller
      class  func topMostViewController(rootViewController: UIViewController) -> UIViewController? {
            if let navigationController = rootViewController as? UINavigationController {
                return topMostViewController(rootViewController: navigationController.visibleViewController!)
            }
            if let tabBarController = rootViewController as? UITabBarController {
                if let selectedTabBarController = tabBarController.selectedViewController {
                    return topMostViewController(rootViewController: selectedTabBarController)
                }
            }
            if let presentedViewController = rootViewController.presentedViewController {
                return topMostViewController(rootViewController: presentedViewController)
            }
            return rootViewController
        }
        
        // MARK: - Get root view controller
      class  func rootViewController() -> UIViewController {
            return (UIApplication.shared.keyWindow?.rootViewController)!
        }
}
