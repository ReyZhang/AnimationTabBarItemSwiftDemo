//
//  Tools.swift
//  AnimationTabBarItemsDemo
//
//  Created by 刘光军 on 16/3/5.
//  Copyright © 2016年 刘光军. All rights reserved.
//

import UIKit

//MARK:-UIColor
extension UIColor {
    class func colorWithCustom(_ r:CGFloat, g:CGFloat, b:CGFloat)->UIColor {
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1)
    }
}
public let LGJGlobalBackgroundColor = UIColor.colorWithCustom(239, g: 239, b: 239)

//MARK:-FRAME
public let ScreenWidth:CGFloat = UIScreen.main.bounds.size.width
public let ScreenHeight:CGFloat = UIScreen.main.bounds.size.height
public let ScreenBounds:CGRect = UIScreen.main.bounds

extension UIView {
    
    var x:CGFloat {
        return self.bounds.origin.x
    }
    var y:CGFloat {
        return self.bounds.origin.y
    }
    var width:CGFloat {
        return self.bounds.size.width
    }
    var height:CGFloat {
        return self.bounds.size.height
    }
    var size: CGSize {
        return self.bounds.size
    }
    var point:CGPoint {
        return self.frame.origin
    }
    
}

//MARK:-NOTIFICATION
public let GuideViewControllerDidFinish = "GuideViewControllerDidFinish"




