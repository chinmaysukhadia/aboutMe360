//
//  DIConfigurator.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 12/09/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import Foundation
import UIKit

class DIConfigurator {
    
    
    //MARK: - LandingViewController
    
    class func landingViewController() -> UIViewController? {
        guard let landingViewController = UIStoryboard(.loginSignup).instantiateViewController(withIdentifier: LandingViewController.className) as? LandingViewController else {
            return nil
        }
        return landingViewController
    }
    
    //MARK: - LoginViewController
    
    class func loginViewController() -> UIViewController? {
        guard let loginViewController = UIStoryboard(.loginSignup).instantiateViewController(withIdentifier: LoginViewController.className) as? LoginViewController else {
            return nil
        }
        return loginViewController
    }
    
    //MARK: - SignUpViewController
    
    class func signUpViewController() -> UIViewController? {
        guard let signUpViewController = UIStoryboard(.loginSignup).instantiateViewController(withIdentifier: SignUpViewController.className) as? SignUpViewController else {
            return nil
        }
        return signUpViewController
    }
    
    //MARK: - ForgotPasswordViewController
    
    class func forgotPasswordViewController() -> UIViewController? {
        guard let forgotPasswordViewController = UIStoryboard(.loginSignup).instantiateViewController(withIdentifier: ForgotPasswordViewController.className) as? ForgotPasswordViewController else {
            return nil
        }
        return forgotPasswordViewController
    }
    
    //MARK: - ResetPasswordViewController
    
    class func resetPasswordViewController() -> UIViewController? {
        guard let resetPasswordViewController = UIStoryboard(.loginSignup).instantiateViewController(withIdentifier: ResetPasswordViewController.className) as? ResetPasswordViewController else {
            return nil
        }
        return resetPasswordViewController
    }
    
    //MARK: - ResetPasswordViewController
    
    class func verificationViewController() -> UIViewController? {
        guard let verificationViewController = UIStoryboard(.loginSignup).instantiateViewController(withIdentifier: VerificationViewController.className) as? VerificationViewController else {
            return nil
        }
        return verificationViewController
    }
    
    //MARK: - ProfilePictureViewController
    
    class func profilePictureViewController() -> UIViewController? {
        guard let profilePictureViewController = UIStoryboard(.loginSignup).instantiateViewController(withIdentifier: ProfilePictureViewController.className) as? ProfilePictureViewController else {
            return nil
        }
        return profilePictureViewController
    }
    
    //MARK: - ProfileViewController
    
    class func profileViewController() -> UIViewController? {
        guard let profileViewController = UIStoryboard(.loginSignup).instantiateViewController(withIdentifier: ProfileViewController.className) as? ProfileViewController else {
            return nil
        }
        return profileViewController
    }
    
    //MARK: - ResetPasswordAleartViewController
    
    class func resetPasswordAleartViewController() -> UIViewController? {
        guard let resetPasswordAleartViewController = UIStoryboard(.loginSignup).instantiateViewController(withIdentifier: ResetPasswordAleartViewController.className) as? ResetPasswordAleartViewController else {
            return nil
        }
        return resetPasswordAleartViewController
    }
    
    //MARK: - EditHeighestQualificationViewController
    
    class func editHeighestQualificationViewController() -> UIViewController? {
        guard let editHeighestQualificationViewController = UIStoryboard(.main).instantiateViewController(withIdentifier: EditHeighestQualificationViewController.className) as? EditHeighestQualificationViewController else {
            return nil
        }
        return editHeighestQualificationViewController
    }
    
    //MARK: - HelpViewController
    
    class func helpViewController() -> UIViewController? {
        guard let helpViewController = UIStoryboard(.main).instantiateViewController(withIdentifier: HelpViewController.className) as? HelpViewController else {
            return nil
        }
        return helpViewController
    }
    
    //MARK: - HelpViewController
    
    class func helpDetailsViewController() -> UIViewController? {
        guard let helpDetailsViewController = UIStoryboard(.main).instantiateViewController(withIdentifier: HelpDetailsViewController.className) as? HelpDetailsViewController else {
            return nil
        }
        return helpDetailsViewController
    }
    
    //MARK: - ProfileSettingViewController
    
    class func profileSettingViewController() -> UIViewController? {
        guard let profileSettingViewController = UIStoryboard(.main).instantiateViewController(withIdentifier: ProfileSettingViewController.className) as? ProfileSettingViewController else {
            return nil
        }
        return profileSettingViewController
    }
    
    //MARK: - DeactivationAccountViewController
    
    class func deactivationAccountViewController() -> UIViewController? {
        guard let deactivationAccountViewController = UIStoryboard(.main).instantiateViewController(withIdentifier: DeactivationAccountViewController.className) as? DeactivationAccountViewController else {
            return nil
        }
        return deactivationAccountViewController
    }
    
    //MARK: - DeactivationCompleteViewController
    
    class func deactivationCompleteViewController() -> UIViewController? {
        guard let deactivationCompleteViewController = UIStoryboard(.main).instantiateViewController(withIdentifier: DeactivationCompleteViewController.className) as? DeactivationCompleteViewController else {
            return nil
        }
        return deactivationCompleteViewController
    }
    
    //MARK: - FeedbackViewController
    
    class func feedbackViewController() -> UIViewController? {
        guard let feedbackViewController = UIStoryboard(.main).instantiateViewController(withIdentifier: FeedbackViewController.className) as? FeedbackViewController else {
            return nil
        }
        return feedbackViewController
    }
    
    //MARK: - FeedbackRatingViewController
    
    class func feedbackRatingViewController() -> UIViewController? {
        guard let feedbackRatingViewController = UIStoryboard(.main).instantiateViewController(withIdentifier: FeedbackRatingViewController.className) as? FeedbackRatingViewController else {
            return nil
        }
        return feedbackRatingViewController
    }
    
    //MARK: - FeedbackCommentViewController
    
    class func feedbackCommentViewController() -> UIViewController? {
        guard let feedbackCommentViewController = UIStoryboard(.main).instantiateViewController(withIdentifier: FeedbackCommentViewController.className) as? FeedbackCommentViewController else {
            return nil
        }
        return feedbackCommentViewController
    }
    
    //MARK: - DetailedRatingViewController
    
    class func detailedRatingViewController() -> UIViewController? {
        guard let detailedRatingViewController = UIStoryboard(.main).instantiateViewController(withIdentifier: DetailedRatingViewController.className) as? DetailedRatingViewController else {
            return nil
        }
        return detailedRatingViewController
    }
    
    //MARK: - QuestionsViewController
    
    class func questionsViewController() -> UIViewController? {
        guard let questionsViewController = UIStoryboard(.main).instantiateViewController(withIdentifier: QuestionsViewController.className) as? QuestionsViewController else {
            return nil
        }
        return questionsViewController
    }
    
    //MARK: - EditProfileViewController
    
    class func editProfileViewController() -> UIViewController? {
        guard let editProfileViewController = UIStoryboard(.main).instantiateViewController(withIdentifier: EditProfileViewController.className) as? EditProfileViewController else {
            return nil
        }
        return editProfileViewController
    }
    
    //MARK: - MinRatingPopupViewController
    
    class func minRatingPopupViewController() -> UIViewController? {
        guard let minRatingPopupViewController = UIStoryboard(.main).instantiateViewController(withIdentifier: MinRatingPopupViewController.className) as? MinRatingPopupViewController else {
            return nil
        }
        return minRatingPopupViewController
    }
    
    //MARK: - SelectedRelationViewController
    
    class func selectedRelationViewController() -> UIViewController? {
        guard let selectedRelationViewController = UIStoryboard(.main).instantiateViewController(withIdentifier: SelectedRelationViewController.className) as? SelectedRelationViewController else {
            return nil
        }
        return selectedRelationViewController
    }
    
    //MARK: - NotificationViewController
    
    class func notificationViewController() -> UIViewController? {
        guard let notificationViewController = UIStoryboard(.tabbar).instantiateViewController(withIdentifier: NotificationViewController.className) as? NotificationViewController else {
            return nil
        }
        return notificationViewController
    }
    
    
    //MARK: - QuestionsSubmitViewController
    
    class func questionsSubmitViewController() -> UIViewController? {
        guard let questionsSubmitViewController = UIStoryboard(.main).instantiateViewController(withIdentifier: QuestionsSubmitViewController.className) as? QuestionsSubmitViewController else {
            return nil
        }
        return questionsSubmitViewController
    }
    
    //MARK: - TabbarViewController
    
    class func tabbarViewController() -> UIViewController? {
        guard let tabbarViewController = UIStoryboard(.tabbar).instantiateViewController(withIdentifier: TabbarViewController.className) as? TabbarViewController else {
            return nil
        }
        return tabbarViewController
    }
    
    //MARK: - OtherProfileViewController
    
    class func otherProfileViewController() -> UIViewController? {
        guard let otherProfileViewController = UIStoryboard(.main).instantiateViewController(withIdentifier: OtherProfileViewController.className) as? OtherProfileViewController else {
            return nil
        }
        return otherProfileViewController
    }
    
    //MARK: - PopupViewController
    
    class func popupViewController() -> UIViewController? {
        guard let popupViewController = UIStoryboard(.main).instantiateViewController(withIdentifier: PopupViewController.className) as? PopupViewController else {
            return nil
        }
        return popupViewController
    }
        
}
