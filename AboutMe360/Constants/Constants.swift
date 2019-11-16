//
//  Constants.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 12/09/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import Foundation
import Foundation
import UIKit

struct Constants {

    struct Keys {
        static let kMobileNumer = "phone"
        static let kPassword = "password"
        static let kName = "name"
        static let kEmail = "email"
        static let kHighQualification = "h_qualification"
        static let kdob = "dob"
        static let kDesignation = "designation"
        static let kOrgName = "org_name"
        static let kIndustry = "industry"
        static let kJobProfile = "job_profile"
        static let kWorkLocation = "work_location"
        static let kStartDate = "startDate"
        static let kEndDate = "endDate"
        static let kFcm_token = "fcm_token"
        static let kStatus = "status"
        static let kAuthUserName = "authUserName"
        static let kAuthPassword = "authPassword"
        static let kMessage = "message"
        static let kToken = "token"
        static let kUserID = "user_id"
        static let kOtp = "otp"
        static let kDuration = "duration"
        static let kProfileImg = "profile_img"
        static let kFullName = "full_name"
        static let kCurrentlyWorking = "currently_working"
        static let kPtoggleValue = "ptoggle_value"
        static let kIssue = "issue"
        static let kExpID = "exp_id"
        static let kID = "id"
        static let kFilter = "filter"
        static let kLastID = "last_id"
        static let kTempRatingID = "temp_rating_id"
        static let kRating = "rating"
        static let kText = "text"
        static let kSearchInput = "searchInput"
        static let kIsInvited = "is_invited"
        static let kTypeID = "type_id"
        static let kCatID = "c_id"
        static let kRatedTO = "rated_to"


        
        
    }
    
    struct ValidationsLength {
        static let maxPasswordLength = 20
        static let firstNameMaxLength = 25
        static let lastNameMaxLength = 25
        static let firstNameMinLength = 2
        static let mobileNumberMaxLength = 10 // 10 for mobile length and 2 for "-" sign
        static let passwordNumberMaxLength = 16
        static let emailMaxLength = 128

    }
    
}

struct StringConstants {

    static let name = "Full Name"
    static let email = "Email"
    static let mobileNumer = "Mobile Numer"
    static let Password = "Password"
    static let cancel = "Cancel"
    static let no = "No"
    static let done = "Done"
    static let ok = "Ok"
    static let designation = "Designation at current/last Organisation"
    static let lastOrganisation = "Current/Last organisation Name"
    static let industry = "Industry"
    static let jobProfile = "Job Profile"
    static let workLocation = "Work Location"
    static let threeDot = "•••"
    static let enterFirstName = "Enter name"
    static let enterLastName = "Enter last name"
    static let enterMobileNumber = "Enter mobile number"
    static let enterValidMobileNumber = "Enter valid mobile number"
    static let enterEmailAddress = "Enter email address"
    static let enterAValidEmailAddress = "Enter a valid email address"
    static let enterPassword = "Please enter password"
    static let confirmPassword = "Please enter confirm Password"
    static let confirmPasswordValidation = "Confirm password should be same as password."
    static let enterBirthday = "Enter your birthday"
    static let passwordDoNotMatch = "Passwords do not match"
    static let passwordShouldBeBetween = "Your password should be between 8-16 characters"
    static let enterOTP = "Please enter OTP"
    static let enter4DigitOTP = "Please enter 4-digit OTP"
    static let enterStartDate = "Please enter start date."
    static let enterEndDate = "Please enter end date."
    static let PleaseAcceptPrivacyPolicy = "Please accept privacy policy"
    static let enterHighQualification = "Enter high qualification"
    static let PleaseUploadProfilePiture = "Please upload profile piture"
    static let enterDesignation = "Enter designation"
    static let enterOrganizationName = "Enter organization name"
    static let selectIndustry = "Select industry"
    static let selectJobProfile = "Select job profile"
    static let enterWorkLocation = "Enter work location"
    static let PleaseSelectResaon = "Please select a resaon"
    static let view = "View"
    static let pending = "Pending"
    static let something = "Something went wrong, please try again"
    static let invalidOtp = "Invalid otp"
    static let ratingInviteesOnly = "Rating by invitees only"
    static let ratingOpenAll = "Rating open to all"
    static let rateYourself = "Rate Yourself"
    static let pleaseSelectYourExperience = "Please select your experience"
    static let shareFeedBack = "Please share your valuable feedback "
    static let accepted = "Accepted"
    static let declined = "Declined"
    static let change = "Change"

}

struct DateFormate {
    static let ddMMyyyy = "dd/MM/yyyy"
}


struct color {
    static let appBlueColor = UIColor(red: 40/255.0, green: 119/255.0, blue: 181/255.0, alpha: 1.0)
    static let appDarkBlueColor = UIColor(red: 4/255.0, green: 44/255.0, blue: 92/255.0, alpha: 1.0)
    static let appLightBlueColor = UIColor(red: 142/255.0, green: 154/255.0, blue: 175/255.0, alpha: 1.0)

}

let kBaseURL = "https://www.aboutme360.com/aboutme/"
//Case for each API method
enum APIName: String {
    case signin          = "users/signin.php?"
    case forgotPassword  = "users/forgot_pass.php"
    case verifyForgotPass  = "users/verify_fpass.php?"
    case setNewPassword  = "users/set_npass.php"
    case signup  = "users/signup.php"
    case verifySignUp  = "users/verify_otp.php?"
    case createProfile  = "users/create_profile.php?"
    case profileToggle  = "users/profile_toggle.php?"
    case readProfile  = "users/read_profile.php"
    case updateProfile = "users/update_profile.php?"
    case deactivateAccount = "users/deactivate_acc.php"
    case editHqualification = "users/edit_hqualification.php?"
    case addExp = "users/create_exp.php"
    case editExp = "users/update_exp.php"
    case deleteExp = "users/delete_experience.php"
    case updateOtp = "users/otp_update.php?"
    case searchKeyword = "cat_and_ques/search_keyword.php?"
    case selfRating = "rating/self_rating.php?"
    case rateMe = "rating/rate_me.php?"
    case notification = "rating/fetch_notifi.php"
    case acceptRating = "rating/accept_rating.php?"
    case declineRating = "rating/decline_rating.php?"
    case feedback = "/users/feedback.php?"
    case searchOrg = "cat_and_ques/search_org.php?"

}

let kSuccessStatus = 200
let kExperience = "experience"
let kHqualification = "qualification"
let kTypeAvgRating = "typeAvgRating"
let kCatavgrating = "catavgrating"
let kTopTraites = "topTraites"

let TabbarHeight = 49 + 10







