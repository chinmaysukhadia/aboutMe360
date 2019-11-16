//
//  ImagePickerHandler.swift
//  Book Trader
//
//  Created by Dharmendra Singh on 24/06/19.
//  Copyright © 2018 Dharmendra Singh NS804. All rights reserved.
//

import Foundation
import UIKit
import MobileCoreServices
import AVFoundation

class ImagePickerHandler: NSObject
{
  static let sharedHandler = ImagePickerHandler()
  var guestInstance: UIViewController? = nil
  var imageClosure: ((UIImage)->())? = nil
  var imgInfoClosure: (([String: Any])->())? = nil
  
  // Public Methods
  
  func getImage(instance: UIViewController, rect: CGRect?, allowEditing: Bool? = true , completion: ((_ myImage: UIImage)->())?)
  {
    Threads.performTaskInMainQueue {
      self.guestInstance = instance
      let imgPicker = UIImagePickerController()
      imgPicker.delegate = self
      imgPicker.allowsEditing = allowEditing ?? true
      imgPicker.mediaTypes = [(kUTTypeImage) as String]
      let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
      let actionSelectCamera = UIAlertAction(title: "Camera", style: .default, handler: {
        UIAlertAction in
        self.openCamera(picker: imgPicker)
      })
      let actionSelectGallery = UIAlertAction(title: "Photo Library", style: .default, handler: {
        UIAlertAction in
        self.openGallery(picker: imgPicker)
        
      })
      let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
      actionSheet.addAction(actionCancel)
      actionSheet.addAction(actionSelectCamera)
      actionSheet.addAction(actionSelectGallery)
      
      if UIDevice.current.userInterfaceIdiom == .phone
      {
        self.guestInstance?.present(actionSheet, animated: true, completion: nil)
      }
      else if rect != nil
      {
        actionSheet.popoverPresentationController?.sourceView = self.guestInstance?.view
        actionSheet.popoverPresentationController?.sourceRect = rect!
        actionSheet.popoverPresentationController?.permittedArrowDirections = .any
        self.guestInstance?.present(actionSheet, animated: true, completion: nil)
      }
      self.imageClosure = {
        (image) in
        completion?(image)
      }
    }
  }
  
  func getImageDict(instance: UIViewController, rect: CGRect?, completion: ((_ imgDict: [String: Any])->())?)
  {
    Threads.performTaskInMainQueue {
      self.guestInstance = instance
      let imgPicker = UIImagePickerController()
      imgPicker.delegate = self
      imgPicker.allowsEditing = true
      imgPicker.mediaTypes = [(kUTTypeImage) as String]
      let actionSheet = UIAlertController(title: "Select Image", message: "Choose an option", preferredStyle: .actionSheet)
      let actionSelectCamera = UIAlertAction(title: "Camera", style: .default, handler: {
        UIAlertAction in
        self.openCamera(picker: imgPicker)
      })
      let actionSelectGallery = UIAlertAction(title: "Gallery", style: .default, handler: {
        UIAlertAction in
        self.openGallery(picker: imgPicker)
        
      })
      let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
      actionSheet.addAction(actionCancel)
      actionSheet.addAction(actionSelectCamera)
      actionSheet.addAction(actionSelectGallery)
      
      if UIDevice.current.userInterfaceIdiom == .phone
      {
        self.guestInstance?.present(actionSheet, animated: true, completion: nil)
      }
      else
      {
        actionSheet.popoverPresentationController?.sourceView = self.guestInstance?.view
        actionSheet.popoverPresentationController?.sourceRect = rect!
        actionSheet.popoverPresentationController?.permittedArrowDirections = .up
        self.guestInstance?.present(actionSheet, animated: true, completion: nil)
      }
      
      self.imgInfoClosure = {
        dictInfo in
        completion?(dictInfo)
      }
    }
  }
  
  func getImage(instance: UIViewController,isSourceCamera: Bool,completion: ((_ myImage: UIImage)->())?)
  {
    Threads.performTaskInMainQueue {
      self.guestInstance = instance
      let imgPicker = UIImagePickerController()
      imgPicker.delegate = self
      imgPicker.allowsEditing = true
      imgPicker.mediaTypes = [(kUTTypeImage) as String]
      if isSourceCamera
      {
        self.openCamera(picker: imgPicker)
      }
      else
      {
        self.openGallery(picker: imgPicker)
      }
      self.imageClosure = {
        (image) in
        completion?(image)
      }
    }
  }
  
  func getImageDict(instance: UIViewController,isSourceCamera:Bool,rect: CGRect?, completion: ((_ imgDict: [String: Any])->())?)
  {
    Threads.performTaskInMainQueue {
      self.guestInstance = instance
      let imgPicker = UIImagePickerController()
      imgPicker.delegate = self
      imgPicker.allowsEditing = true
      imgPicker.mediaTypes = [(kUTTypeImage) as String]
      if isSourceCamera
      {
        self.openCamera(picker: imgPicker)
      }
      else
      {
        self.openGallery(picker: imgPicker)
      }
      
      self.imgInfoClosure = {
        dictInfo in
        completion?(dictInfo)
      }
    }
  }
  
  func getImageOrVideo(instance: UIViewController, rect: CGRect?, completion: ((_ imgDict: [String: Any])->())?)
  {
    Threads.performTaskInMainQueue {
      self.guestInstance = instance
      let imgPicker = UIImagePickerController()
      imgPicker.delegate = self
      imgPicker.allowsEditing = true
      imgPicker.mediaTypes = [(kUTTypeImage) as String,(kUTTypeMovie) as String]
      imgPicker.videoMaximumDuration = 60
      imgPicker.videoQuality = UIImagePickerController.QualityType.typeMedium
      let actionSheet = UIAlertController(title: "Select Image", message: "Choose an option", preferredStyle: .actionSheet)
      let actionSelectCamera = UIAlertAction(title: "Camera", style: .default, handler: {
        UIAlertAction in
        self.openCamera(picker: imgPicker)
      })
      let actionSelectGallery = UIAlertAction(title: "Gallery", style: .default, handler: {
        UIAlertAction in
        self.openGallery(picker: imgPicker)
        
      })
      let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
      actionSheet.addAction(actionCancel)
      actionSheet.addAction(actionSelectCamera)
      actionSheet.addAction(actionSelectGallery)
      
      if UIDevice.current.userInterfaceIdiom == .phone
      {
        Threads.performTaskInMainQueue {
          self.guestInstance?.present(actionSheet, animated: true, completion: nil)
        }
      }
      else if rect != nil
      {
        actionSheet.popoverPresentationController?.sourceView = self.guestInstance?.view
        actionSheet.popoverPresentationController?.sourceRect = rect!
        actionSheet.popoverPresentationController?.permittedArrowDirections = .any
        Threads.performTaskInMainQueue {
          self.guestInstance?.present(actionSheet, animated: true, completion: nil)
        }
      }
      self.imgInfoClosure = {
        dictInfo in
        completion?(dictInfo)
      }
    }
  }
  
  //Private Methods
  
  private func openCamera(picker: UIImagePickerController)
  {
    if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
    {
      picker.sourceType = UIImagePickerController.SourceType.camera
      picker.edgesForExtendedLayout = UIRectEdge.all
      picker.showsCameraControls = true
      self.guestInstance?.present(picker, animated: true, completion: nil)
    }
    else
    {
      let alert = UIAlertController(title: "Warning", message: "Camera is not available", preferredStyle: .alert)
      let actionOK = UIAlertAction(title: "Ok", style: .default, handler: nil)
      alert.addAction(actionOK)
      self.guestInstance?.present(alert, animated: true, completion: nil)
    }
  }
  
  private func openGallery(picker: UIImagePickerController)
  {
    picker.sourceType = UIImagePickerController.SourceType.photoLibrary
    self.guestInstance?.present(picker, animated: true, completion: nil)
  }
}

//MARK: - UIImagePicker Delegates
extension ImagePickerHandler: UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) //Cancel button  of imagePicker
  {
    picker.dismiss(animated: true, completion: nil)
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) //Picking Action of ImagePicker
  {
    // Local variable inserted by Swift 4.2 migrator.
    let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
    
    picker.dismiss(animated: true, completion: nil)
    imgInfoClosure?(info)
    
    if let img = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage {
      imageClosure?(img)
    }
  }
}


// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
  return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
  return input.rawValue
}
