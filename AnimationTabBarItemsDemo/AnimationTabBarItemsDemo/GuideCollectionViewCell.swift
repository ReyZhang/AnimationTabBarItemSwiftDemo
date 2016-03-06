//
//  GuideCollectionViewCell.swift
//  AnimationTabBarItemsDemo
//
//  Created by 刘光军 on 16/3/5.
//  Copyright © 2016年 刘光军. All rights reserved.
//

import UIKit

class GuideCollectionViewCell: UICollectionViewCell {
    
    
    private let newImageView = UIImageView(frame: ScreenBounds)
    private let nextBtn = UIButton(frame: CGRectMake((ScreenWidth - 100)*0.5, ScreenHeight - 110, 100, 33))
    
    var newImage:UIImage? {
        didSet{
            newImageView.image = newImage
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        newImageView.contentMode = UIViewContentMode.ScaleAspectFill
        contentView.addSubview(newImageView)
        
        nextBtn.setBackgroundImage(UIImage(named: "icon_next"), forState: .Normal)
        nextBtn.addTarget(self, action: "nextBtnClick", forControlEvents: .TouchUpInside)
        nextBtn.hidden = true
        contentView.addSubview(nextBtn)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setNextBtnHidden(hidden:Bool) {
        nextBtn.hidden = hidden
    }
    
    func nextBtnClick() {
        NSNotificationCenter.defaultCenter().postNotificationName(GuideViewControllerDidFinish, object: nil)
    }
    
}
