//
//  ProfilePictureViewController.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 9/11/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import UIKit
import CropViewController

class ProfilePictureViewController: BaseViewController {

    //MARK: - IBOutlets
    
    @IBOutlet weak var txtHighQualification: ACFloatingTextfield!
    @IBOutlet weak var txtDOB: ACFloatingTextfield!
    @IBOutlet weak var imageViewHighQualificationCheck: UIImageView!
    @IBOutlet weak var imageViewDOBCheck: UIImageView!
    @IBOutlet weak var imageViewProfilePiture: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    //MARK: - Variables
    
    var dataDict = [String: String]()
    var datePicker = UIDatePicker()
    var name: String?
    var profilePictureViewModel: ProfilePictureViewModel?
    
    var highQualification:String? {
        didSet {
            self.dataDict[Constants.Keys.kHighQualification] = highQualification
        }
    }
    
    var dob:String? {
        didSet {
            self.dataDict[Constants.Keys.kdob] = dob
            self.txtDOB.text = dob
        }
    }
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setUp()
    }

    //MARK: - Private Methods
    
    private func setUp() {
        self.imageViewHighQualificationCheck.isHidden =  true
        self.imageViewDOBCheck.isHidden =  true
       // self.imageViewProfilePiture.roundCorners(85)
        self.imageViewProfilePiture.makeLayer(color: color.appBlueColor, boarderWidth: 3, round: 85)
        self.txtHighQualification.autocapitalizationType = .words


//        if let name = name {
//            self.nameLabel.text = "Hi " + name + "Update your profile picture."
//            Hi! Update your profile picture.
//        }
        
        self.nameLabel.text = "Hi! Update your profile picture."

        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        txtDOB.inputView = self.datePicker
        txtDOB.addDoneButtonOnKeyboard(false)
        self.datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        self.setUpViewModel()
        self.setUpDelegate()
        self.dataDict[Constants.Keys.kProfileImg] = ""
    }
    
    private func setUpDelegate() {
        txtHighQualification.delegate = self
        txtDOB.delegate = self
    }
    
    // Model Initialization
    private func setUpViewModel() {
        profilePictureViewModel = ProfilePictureViewModel()
    }
    
    private func addDoneButtonOnKeyboard(_ textField: UITextField, showCancelButton: Bool = false) {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: StringConstants.done, style: .done, target: self, action: #selector(self.doneButtonTapped))
        
        var items = [flexSpace, done]
        if showCancelButton {
            let cancel: UIBarButtonItem = UIBarButtonItem(title: StringConstants.cancel, style: .plain, target: self, action: #selector(self.cancelButtonTapped))
            items = [cancel, flexSpace, done]
        }
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        textField.inputAccessoryView = doneToolbar
    }
    
    @objc func dateChanged(_ sender: UIDatePicker) {
        dob = sender.date.dateStringWith(strFormat: DateFormate.ddMMyyyy)
    }
    
    //MARK: - Selector Methods
    @objc func doneButtonTapped() {
        self.view.endEditing(true)
    }
    
    @objc func cancelButtonTapped() {
        self.view.endEditing(true)
    }
    //MARK: - IBAction
    
    @IBAction func uploadProfileButtonTapped(_ sender: Any) {
        
        DeviceSettings.checklibrarySettings(self) { (success) in
            if success {
                ImagePickerHandler.sharedHandler.getImage(instance: self, rect: nil, allowEditing: false, completion: { (image) in
                  // self.imageViewProfilePiture.image = image
                    Threads.performTaskInMainQueue {
                        let cropViewController = CropViewController(croppingStyle: .default, image: image)
                        cropViewController.delegate = self
                        cropViewController.aspectRatioPickerButtonHidden = true
                        cropViewController.rotateButtonsHidden = true
                        cropViewController.rotateClockwiseButtonHidden = true
                        cropViewController.resetButtonHidden = true
                        cropViewController.customAspectRatio = CGSize(width: 3.0, height: 3.0)
                        cropViewController.aspectRatioLockEnabled = true
                        cropViewController.toolbarPosition = .top
                        self.present(cropViewController, animated: false, completion: nil)
                    }
                })
            }
        }
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func continueButtonTapped(_ sender: Any) {
        
        self.profilePictureViewModel?.validateProfilePictureFormData(dataDict: self.dataDict, completion: { (success, message) in
            if !success {
                Utilities.showToast(message: message)
            } else {
                
                guard let profileVC = DIConfigurator.profileViewController() as? ProfileViewController  else {
                    return
                }
                profileVC.signType = .signUp
                profileVC.dataDict = self.dataDict
                self.navigationController?.pushViewController(profileVC, animated: true)
            }
        })
    }

}

extension ProfilePictureViewController : UITextFieldDelegate  {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text, let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            switch textField {
            case txtHighQualification:
                self.highQualification = updatedText
            default:
                print("#####")
            }
        }
        return true
    }
}

extension ProfilePictureViewController: CropViewControllerDelegate {
    
    func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        // 'image' is the newly cropped version of the original image
        self.imageViewProfilePiture.image = image
        self.dataDict[Constants.Keys.kProfileImg] = image.toBase64(format: .jpeg(0.8))
        self.dismiss(animated: false)
    }
    
    func cropViewController(_ cropViewController: CropViewController, didFinishCancelled cancelled: Bool) {
        
        self.dismiss(animated: false)
    }
}
