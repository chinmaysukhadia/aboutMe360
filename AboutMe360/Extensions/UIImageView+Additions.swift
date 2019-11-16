//
//  UIImageView+Additions.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 27/09/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

extension UIImageView {
    
    func setImageForRtoL() {
        if UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft, let image = self.image {
            let filppedImage = image.imageFlippedForRightToLeftLayoutDirection()
            self.image = filppedImage
        }
    }
    
    func setImage(urlStr: String, placeHolderImage: UIImage?)  {
        self.sd_setImage(with: URL(string: urlStr), placeholderImage: placeHolderImage)
    }
    
}
