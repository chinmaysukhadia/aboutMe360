
import UIKit

class Tabbar: UITabBar {

    override var traitCollection: UITraitCollection {
        guard UIDevice.current.userInterfaceIdiom == .pad else {
            return super.traitCollection
        }
        
        return UITraitCollection(horizontalSizeClass: .compact)
    }
    
    override public func sizeThatFits(_ size: CGSize) -> CGSize {
        super.sizeThatFits(size)
        var sizeThatFits = super.sizeThatFits(size)
        
        var safeAreaBottom: CGFloat = 0.0
        
        if #available(iOS 11.0, *) {
            if let window = UIApplication.shared.keyWindow {
                safeAreaBottom = window.safeAreaInsets.bottom
            }
        }
        
        sizeThatFits.height = safeAreaBottom + CGFloat(TabbarHeight)
       
        return sizeThatFits
    }

}
