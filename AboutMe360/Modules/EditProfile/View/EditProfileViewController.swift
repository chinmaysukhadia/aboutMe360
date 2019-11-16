//
//  EditProfileViewController.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 25/09/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import UIKit
import SwiftyUserDefaults
import CropViewController
class EditProfileViewController: BaseViewController {

    //MARK: - IBOutlets
    
    @IBOutlet weak var txtName: ACFloatingTextfield!
    @IBOutlet weak var txtEmail: ACFloatingTextfield!
    @IBOutlet weak var txtMobileNumber: ACFloatingTextfield!
    @IBOutlet weak var txtDob: ACFloatingTextfield!
    @IBOutlet weak var imageViewProfilePiture: UIImageView!
    @IBOutlet weak var imageViewCamera: UIImageView!
    @IBOutlet weak var uploadButton: UIButton!


    //MARK: - Variables
    
    var dataDict:[String: String] = [:]
    var editProfileViewModel: EditProfileViewModel?
    var datePicker = UIDatePicker()
    var callBack: (() ->Void)?


    var name: String? {
        didSet {
            dataDict[Constants.Keys.kFullName] = name
           // txtName.text = name
        }
    }
    
    var email: String? {
        didSet {
            dataDict[Constants.Keys.kEmail] = email
           // txtEmail.text = email

        }
    }
    
    var dob: String? {
        didSet {
            dataDict[Constants.Keys.kdob] = dob
          //  txtDob.text = dob
        }
    }
    
    var mobileNumber: String? {
        didSet {
            dataDict[Constants.Keys.kMobileNumer] = mobileNumber
           // txtMobileNumber.text = mobileNumber
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
        self.renderData()
        self.txtMobileNumber.delegate =  self
        self.txtName.delegate =  self
        self.txtDob.delegate =  self
        self.txtEmail.delegate =  self
        self.txtName.autocapitalizationType = .words
        self.uploadButton.makeLayer(color: color.appBlueColor, boarderWidth: 3, round: 60)
        imageViewCamera.roundCorners(25)
        imageViewProfilePiture.roundCorners(40)
        self.txtMobileNumber.addDoneButtonOnKeyboard()
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        txtDob.inputView = self.datePicker
        txtDob.addDoneButtonOnKeyboard(false)
        self.datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        self.setUpViewModel()
        self.dataDict[Constants.Keys.kProfileImg] = ""
    }
    
    func renderData() {
        
        if let homeModel = Defaults[.profleData] {
            name =  homeModel.homeData?.fullName
            email =  homeModel.homeData?.email
            mobileNumber =  homeModel.homeData?.phone
            dob =  homeModel.homeData?.dob
            txtName.text = name
            txtEmail.text = email
            txtDob.text = dob
            txtMobileNumber.text = mobileNumber
            
            if let url = homeModel.pimgBaseUrl, let profileIgm = homeModel.homeData?.profileImg {
                print(url+profileIgm)
                self.imageViewProfilePiture.setImage(urlStr: url+profileIgm, placeHolderImage: nil)
            }
           // self.profileImageView.setImage(urlStr: profileImage, placeHolderImage: nil)
        }
        
    }
    
    // Model Initialization
    private func setUpViewModel() {
        editProfileViewModel = EditProfileViewModel()
    }
    
    @objc func dateChanged(_ sender: UIDatePicker) {
        dob = sender.date.dateStringWith(strFormat: DateFormate.ddMMyyyy)
        txtDob.text = dob
    }
    
    func updateProfileAPI() {
        
        self.editProfileViewModel?.updateProfileAPI(paramDict: self.dataDict,completion: { (_, success) in
            
            if success {
                self.callBack?()
                self.navigationController?.popToRootViewController(animated: true)
            }
        })

    }
    
    func otpAPI() {
        
        self.editProfileViewModel?.verifyUpdateProfileOTPAPI(paramDict: self.dataDict,completion: { (otp, success) in
            
            if success {
                
                Threads.performTaskInMainQueue {
                    guard let verificationVC = DIConfigurator.verificationViewController() as? VerificationViewController  else {
                        return
                    }
                    verificationVC.verificationType = .editProfile
                    verificationVC.mobileNumber = self.mobileNumber
                    verificationVC.paramsDict = self.dataDict
                    verificationVC.otp = otp as? String
                    verificationVC.callBack = {
                        self.updateProfileAPI()
                    }
                    self.navigationController?.pushViewController(verificationVC, animated: true)
                }
            }
        })

        
    }
    
    //MARK: - IBAction

    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func uploadButtonTapped(_ sender: Any) {
        
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
    
    @IBAction func updateButtonTapped(_ sender: Any) {
        self.view.endEditing(true)
    
        if let homeModel = Defaults[.profleData] {
            let phone =  homeModel.homeData?.phone?.trim()
            
            self.editProfileViewModel?.validateEditProfileFormData(dataDict: self.dataDict, completion: { (success, message) in
                if !success {
                    Utilities.showToast(message: message)
                } else {
                    
                    if phone == self.mobileNumber {
                        self.updateProfileAPI()
                    } else {
                        
                     self.otpAPI()
                    }
                }
            })
        }
    }

}

extension EditProfileViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text, let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            switch textField {
            case txtMobileNumber:
             self.mobileNumber = updatedText
                if updatedText.count>Constants.ValidationsLength.mobileNumberMaxLength {
                    return false
                }
            case txtEmail:
                self.email = updatedText
                if updatedText.count>Constants.ValidationsLength.emailMaxLength {
                    return false
                }
            case txtName:
                self.name = updatedText
                case txtDob:
                self.dob = updatedText
            default:
                print("#####")
            }
            
        }
        return true
    }
}

extension EditProfileViewController: CropViewControllerDelegate {
    
    func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        // 'image' is the newly cropped version of the original image
        self.imageViewProfilePiture.image = image
        self.dataDict[Constants.Keys.kProfileImg] = image.toBase64(format: .jpeg(0.7))
        
        self.dismiss(animated: false)
    }
    
    func cropViewController(_ cropViewController: CropViewController, didFinishCancelled cancelled: Bool) {
        
        self.dismiss(animated: false)
    }
    
}
