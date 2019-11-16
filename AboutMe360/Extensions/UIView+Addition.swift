//
//  UIView+Addition.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 15/09/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import UIKit
import QuartzCore

// MARK: - Properties
public extension UIView {
    
    func initializeFromNibAndGetView(nibNamed: String)-> UIView?
    {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibNamed, bundle: bundle)
        if let view = nib.instantiate(withOwner:nil, options: nil).first as? UIView {
            view.frame = bounds
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            return view
        }
        
        return nil
    }
    
    
    func setViewShadow(color: UIColor,cornerRadius: CGFloat,shadowRadius: CGFloat = 5.0,shadowOpacity: Float = 0.2)
    {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        self.layer.shadowRadius = shadowRadius
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowOpacity = shadowOpacity
    }
    
    func setupCornerShadow(cornerRadius: CGFloat, shadowRadius: CGFloat = 5.0, shadowOpacity: Float = 0.2, byRoundingCorners: UIRectCorner) {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: byRoundingCorners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
    
    
    func animation(view:UIView)
    {
        view.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5.0, options: .allowUserInteraction , animations: {
            view.transform = CGAffineTransform.identity
        }) { (fininsh) in
            
        }
    }
    
    func animateView()
    {
        UIView.animate(withDuration: 0.5, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
        }) { (true) in
            UIView.animate(withDuration: 1.0, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
                self.layoutIfNeeded()
            }) { (true) in
            }
        }
    }
    
    func fadeOut() {
        UIView.animate(withDuration: 0.35, animations: {
            //            self.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }) { (finished : Bool) in
            if finished {
                self.removeFromSuperview()
            }
        }
    }
    
    func applyGradient() -> Void {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [UIColor(red: 0, green: 95.0/255.0, blue: 181.0/255.0, alpha: 1.0).cgColor, UIColor(red: 23.0/255.0, green: 176.0/255.0, blue: 218.0/255.0, alpha: 1.0).cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.43)
        gradient.endPoint = CGPoint(x: 0.43, y: 1.0)
        gradient.cornerRadius = CGFloat(2.5)
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func roundTopCorners(cornerRadius: Double) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }
    
    func addTopRoundedCornerToView(targetView:UIView?, desiredCurve:CGFloat?)
    {
        let offset:CGFloat =  targetView!.frame.width/desiredCurve!
        let bounds: CGRect = targetView!.bounds
        
        let rectBounds: CGRect = CGRect(x: bounds.origin.x, y: bounds.origin.y+bounds.size.height / 2, width: bounds.size.width, height: bounds.size.height / 2)
        
        let rectPath: UIBezierPath = UIBezierPath(rect: rectBounds)
        let ovalBounds: CGRect = CGRect(x: bounds.origin.x - offset / 2, y: bounds.origin.y,width: bounds.size.width + offset, height: bounds.size.height)
        let ovalPath: UIBezierPath = UIBezierPath(ovalIn: ovalBounds)
        rectPath.append(ovalPath)
        
        // Create the shape layer and set its path
        let maskLayer: CAShapeLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = rectPath.cgPath
        
        // Set the newly created shape layer as the mask for the view's layer
        targetView!.layer.mask = maskLayer
    }
    
    func roundCorners(_ cornerRadius: CGFloat) {
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.layer.masksToBounds = true
    }
    
    func makeLayer( color: UIColor, boarderWidth: CGFloat, round:CGFloat) -> Void {
        self.layer.borderWidth = boarderWidth;
        self.layer.cornerRadius = round;
        self.layer.masksToBounds =  true;
        self.layer.borderColor = color.cgColor
    }
}

extension UIView {
    
    func roundCornersSide(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
}

public extension UIView {
    
    func applyCustomGradient(_ firstColor: UIColor, _ secondColor: UIColor) {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [firstColor.cgColor, secondColor.cgColor]
        gradient.startPoint = CGPoint(x: 1.0, y: 0)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.95)
        gradient.cornerRadius = CGFloat(2.5)
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func roundSideCorners(_ corners: UIRectCorner, radius: CGFloat) {
        if #available(iOS 11.0, *) {
            clipsToBounds = true
            layer.cornerRadius = radius
            layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
        } else {
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
    }
}
