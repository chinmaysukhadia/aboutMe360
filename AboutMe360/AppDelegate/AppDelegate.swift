//
//  AppDelegate.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 9/11/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import UIKit
import UserNotifications
import SwiftyUserDefaults
import Firebase
@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    class func delegate()-> AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
       // sleep(2)
        self.registerForPushNotifications(application: application)
        if Defaults[.isLogin] == true {
            self.showTabBar()
        }
        // Use Firebase library to configure APIs
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        UIApplication.shared.applicationIconBadgeNumber = 0
        return true
    }

    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

extension AppDelegate {
    
    //ShowTabBar
    func showTabBar() {
        Defaults[.isLogin] = true
        let tabbarVC =  DIConfigurator.tabbarViewController()
        self.window?.rootViewController = tabbarVC
        self.window?.makeKeyAndVisible()
    }
    
    //
    func showLogin() {
        Defaults[.token] = nil
        Defaults[.profleData] = nil
        Defaults[.userId] = nil
        Defaults[.authToken] = nil
        Defaults[.isLogin] = false

        guard let loginVC =  DIConfigurator.landingViewController() else { return  }
        let navigationController = UINavigationController(rootViewController: loginVC)
        navigationController.navigationBar.isHidden = true
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }

}


//MARK: - Push Notification Methods

extension AppDelegate: UNUserNotificationCenterDelegate , MessagingDelegate {
    
    func registerForPushNotifications(application: UIApplication) {
        
        if #available(iOS 10.0, *) {
          // For iOS 10 display notification (sent via APNS)
          UNUserNotificationCenter.current().delegate = self

          let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
          UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: {_, _ in })
        } else {
          let settings: UIUserNotificationSettings =
          UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
          application.registerUserNotificationSettings(settings)
        }

        application.registerForRemoteNotifications()

    }
    
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
       // Defaults[.deviceToken] = deviceTokenString
        
        InstanceID.instanceID().instanceID { (result, error) in
            if let error = error {
                print(error)
            } else if let result = result {
                print("Remote instance ID token: \(result.token)")
                Defaults[.deviceToken] = result.token
            }
        }
        
        Messaging.messaging().apnsToken = deviceToken
        
        print(deviceTokenString)
    }
    
    func application(application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        Messaging.messaging().apnsToken = deviceToken as Data
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
      print("Firebase registration token: \(fcmToken)")
        Defaults[.deviceToken] = fcmToken
      // TODO: If necessary send token to application server.
      // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
        print("i am not available in simulator \(error)")
        Defaults[.deviceToken] = "12345"
    }
    
    // Banner Tapped - App Active
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        print("User info -----\(userInfo)")
    }
    
    // This method will be called when app receives push notifications in foreground
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        if UIApplication.shared.applicationState == .inactive || UIApplication.shared.applicationState == .background {
            completionHandler([.alert, .badge, .sound])
        }
        
        _ = notification.request.content.body
        
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        
        if url.absoluteString.contains("aboutme360.com") {
            self.handleDeepLinking(url: url)
            return true
        }
        
        return false
    }
}

extension AppDelegate {
    
    func handleDeepLinking(url: URL) {
        
        if Defaults[.isLogin] == false {
            return
        }
        
        let components = url.absoluteString.components(separatedBy: "=")
        
        if let accessKey = components.last, !accessKey.isEmpty {
           // Defaults[.accessKey] = accessKey
         //self.deepLinkingResetPassword()
        }
        
        //        if let accessKey = self.getQueryStringParameter(url:urlStr, param: "accessKey"), !accessKey.isEmpty {
        //            Defaults[.accessKey] = accessKey
        //            self.deepLinkingResetPassword()
        //        }
    }
    
    func getQueryStringParameter(url: String, param: String) -> String? {
        guard let url = URLComponents(string: url) else { return nil }
        return url.queryItems?.first(where: { $0.name == param })?.value
    }
    
}
