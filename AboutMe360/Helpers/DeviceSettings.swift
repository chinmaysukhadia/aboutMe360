//
//  DeviceSettings.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 15/09/19.
//  Copyright © 2019 Appy. All rights reserved.
//



import Foundation
import AVFoundation
import Photos
import Contacts
import UIKit
enum HardWareAccessType: String {
    case camera = "camera"
    case library = "library"
    case email = "email"
    case contacts = "contacts"
    case safari = "safari"
    case location = "location"
}

struct Errors {
    static let InvalidCamera = "To use your camera with AboutMe360, tap Settings -> AboutMe360 and turn on Camera.";
    static let  InvalidLibrary = "To let AboutMe360 access your photo gallery, tap Settings -> GAboutMe360FY and turn on Photos.";
    static let InvalidContacts = "To let AboutMe360 access your contacts, tap Settings -> AboutMe360 and turn on Contacts.";
    static let InvalidEmail = "No email account found.";
}

class DeviceSettings {
    
    // MARK: - Camera and library validation
    
    class func checkCameraSetting( _ target: UIViewController? = AppDelegate.delegate()?.window?.rootViewController , completionClosure: @escaping (_ success: Bool) -> () = {(success) in}) {
        
        let status = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        if(status == AVAuthorizationStatus.authorized) {
            completionClosure(true)
        } else if(status == AVAuthorizationStatus.denied){
            self.openSetting(HardWareAccessType.camera, target: target)
            completionClosure(false)
        } else if(status == AVAuthorizationStatus.notDetermined){
            AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (granted :Bool) -> Void in
                if granted == true {
                    completionClosure(true)
                } else {
                    completionClosure(false)
                    self.openSetting(HardWareAccessType.camera, target: target)
                }
            });
        }
    }
    
    // MARK: - Chech library settings
    
    class func checklibrarySettings(_ target: UIViewController? = AppDelegate.delegate()?.window?.rootViewController, completionClosure: @escaping (_ success: Bool) -> () = {(success) in}) {
        
        PHPhotoLibrary.requestAuthorization { status in
            switch status {
            case .authorized:
                completionClosure(true)
            case .denied:
                completionClosure(false)
                DispatchQueue.main.async(execute: {
                    self.openSetting(HardWareAccessType.library, target: target)
                })
            default:
                completionClosure(true)
                break
            }
        }
    }
    
    // MARK: - Contact validation
    
    class func checkContactSetting( _ target: UIViewController?, displaySetting: Bool, completionClosure: @escaping (_ success: Bool) -> () = {(success) in}) {
        let status = CNContactStore.authorizationStatus(for: .contacts)
        switch status {
        case .denied,
             .notDetermined:
            CNContactStore().requestAccess(for: .contacts, completionHandler: { (granted, error) in
                if granted {
                    completionClosure(true)
                } else {
                    completionClosure(false)
                    if displaySetting {
                        self.openSetting(.contacts, target: target)
                    }
                }
            })
        default:
            completionClosure(true)
            break
        }
    }
    
    // MARK: - Chech location settings
    
    class func checkLocationSettings(_ target: UIViewController? , completionClosure: @escaping (_ success: Bool) -> () = {(success) in}) {
        
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            completionClosure(true)
        case .denied:
            completionClosure(false)
            DispatchQueue.main.async(execute: {
                self.openSetting(HardWareAccessType.location, target: target)
            })
        default:
            completionClosure(true)
            break
        }
    }
    
    // MARK: - Open settings for hardware type
    
    class func openSetting(_ hardWareAccessType : HardWareAccessType , target: UIViewController?){
        
        var InvalidHardware = ""
        switch hardWareAccessType {
        case .camera:
            InvalidHardware = Errors.InvalidCamera
        case .library:
            InvalidHardware = Errors.InvalidLibrary
        case .email:
            InvalidHardware = Errors.InvalidEmail
        case .contacts:
            InvalidHardware = Errors.InvalidContacts
        case .safari:
            InvalidHardware = "Open safari settings"
        case .location:
            InvalidHardware = "Open location settings"
        }
        
        let alertController = UIAlertController (title: "AboutMe360",
                                                 message: InvalidHardware,
                                                 preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
            
            var settingsUrl = URL(string: UIApplication.openSettingsURLString)
            
            if hardWareAccessType == .email {
                settingsUrl = URL(string: UIApplication.openSettingsURLString)
            } else if hardWareAccessType == .safari {
                settingsUrl = URL(string: "App-Prefs:root=SAFARI")
            }
            
            guard let url = settingsUrl else {
                return
            }
            
            if UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, completionHandler: { (success) in
                        //print("Settings opened: \(success)")
                    })
                } else {
                    // Fallback on earlier versions
                }
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(settingsAction)
        alertController.addAction(cancelAction)
        
        DispatchQueue.main.async(execute: {
            var topView: UIViewController? = target
            if topView == nil {
                topView = Utilities.topMostViewController()
            }
            topView?.present(alertController, animated: true, completion: nil)
        })
    }
}

