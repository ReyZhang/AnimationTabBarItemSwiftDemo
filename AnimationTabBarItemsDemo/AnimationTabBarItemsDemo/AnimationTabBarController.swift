//
//  AnimationTabBarController.swift
//  AnimationTabBarItemsDemo
//
//  Created by 刘光军 on 16/3/5.
//  Copyright © 2016年 刘光军. All rights reserved.
//设置底部状态栏动画

import UIKit

protocol RAMItemAnimationProtocol {
    func playAnimation(icon: UIImageView, textLabel:UILabel)
    func deselectAnimation(icon: UIImageView, textLabel: UILabel, defaultTextColor: UIColor)
    func selectedState(icon: UIImageView, textLabel: UILabel)
}

class RAMItemAnimation:NSObject, RAMItemAnimationProtocol {
    
    var duration: CGFloat = 0.6
    var textSelectedColor: UIColor = UIColor.grayColor()
    var iconSelectedColor: UIColor?
    
    func playAnimation(icon: UIImageView, textLabel: UILabel) {
        
    }
    
    func deselectAnimation(icon: UIImageView, textLabel: UILabel, defaultTextColor: UIColor) {
        
    }
    
    func selectedState(icon: UIImageView, textLabel: UILabel) {
        
    }
}

class RAMBounceAnimation: RAMItemAnimation {
    
    override func playAnimation(icon: UIImageView, textLabel: UILabel) {
        
        playBounceAnimation(icon)
        textLabel.textColor = textSelectedColor
    }
    
    override func deselectAnimation(icon: UIImageView, textLabel: UILabel, defaultTextColor: UIColor) {
        
        textLabel.textColor = defaultTextColor
        
        if let iconImage = icon.image {
            let renderImage = iconImage.imageWithRenderingMode(.AlwaysOriginal)
            icon.image = renderImage
            icon.tintColor = defaultTextColor
        }
    }
    
    override func selectedState(icon: UIImageView, textLabel: UILabel) {
        
        textLabel.textColor = textSelectedColor
        
        if let iconImage = icon.image {
            let renderImage = iconImage.imageWithRenderingMode(.AlwaysOriginal)
            icon.image = renderImage
            icon.tintColor = textSelectedColor
        }
    }
    
    
    func playBounceAnimation(icon: UIImageView) {
        
        let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        bounceAnimation.values = [1.0, 1.4, 0.9, 1.15, 0.95, 1.02, 1.0]
        bounceAnimation.duration = NSTimeInterval(duration)
        bounceAnimation.calculationMode = kCAAnimationCubic
        
        icon.layer.addAnimation(bounceAnimation, forKey: "bounceAnimation")
        
        if let iconImage = icon.image {
            let renderImage = iconImage.imageWithRenderingMode(.AlwaysOriginal)
            icon.image = renderImage
            icon.tintColor = iconSelectedColor
        }
    }
}

class RAMAnimatedTabBarItem: UITabBarItem {
    
    var animation: RAMItemAnimation?
    var textColor = UIColor.grayColor()
    
    func playAnimation(icon: UIImageView, textLabel: UILabel) {

        guard let animation = animation else {
            print("add animation in UITabBarItem")
            return
        }
        animation.playAnimation(icon, textLabel: textLabel)
    }
    
    func deselectAnimation(icon: UIImageView, textLabel: UILabel) {
    
        animation?.deselectAnimation(icon, textLabel: textLabel, defaultTextColor: textColor)
    }
    
    func selectedState(icon:UIImageView, textLabel:UILabel) {
        animation?.selectedState(icon , textLabel: textLabel)
    }
    
    
}


class AnimationTabBarController: UITabBarController {
    
    var iconsView:[(icon: UIImageView, textLabel: UILabel)] = []
    var iconsImageName:[String] = ["v2_home", "v2_order", "shopCart", "v2_my"]
    var iconsSelectedImageName:[String] = ["v2_home_r", "v2_order_r", "shopCart_r", "v2_my_r"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //创建承载TabBarItem的视图容器,里面是item中的titleLabel和UIImageView,将视图容器存入字典,以便在后续使用中可以分清是点了哪一个item
    
    func createViewContainers() -> [String: UIView] {
        
        var containersDict = [String: UIView]()
        //tabbar的item是继承的自定义的RAMAnimatedTabBarItem,其中包含了动画设置的函数
        guard let customItems = tabBar.items as? [RAMAnimatedTabBarItem]
            else {
                return containersDict
        }
        //根据item的个数创建视图容器,将视图容器放在字典中
        for index in 0..<customItems.count {
            let viewContainer = createViewContainer(index)
            containersDict["container\(index)"] = viewContainer
        }
        return containersDict
    }
    
    //根据index值创建每个的视图容器
    func createViewContainer(index: Int) -> UIView {
        
        let viewWidth: CGFloat = ScreenWidth / CGFloat(tabBar.items!.count)
        let viewHeight: CGFloat = tabBar.height
        let viewContainer = UIView(frame: CGRectMake(viewWidth * CGFloat(index), 0, viewWidth, viewHeight))
        
        viewContainer.backgroundColor = UIColor.clearColor()
        viewContainer.userInteractionEnabled = true
        
        tabBar.addSubview(viewContainer)
        viewContainer.tag = index
        
        //给容器添加手势,其实是自己重写了系统的item的功能,因为我们要在里面加入动画
        let tap = UITapGestureRecognizer(target: self, action: "tabBarClick:")
        viewContainer.addGestureRecognizer(tap)
        return viewContainer
        
    }
    
    //创建items的具体内容
    func createCustomIcons(containers: [String: UIView]) {
        
        if let items = tabBar.items {
            for (index, item) in items.enumerate() {
                
                assert(item.image != nil, "add image icon in UITabBarItem")
                guard let container = containers["container\(index)"] else {
                    print("No container given")
                    continue
                }
                container.tag = index
                
                let imageW:CGFloat = 21
                let imageX:CGFloat = (ScreenWidth / CGFloat(items.count) - imageW) * 0.5
                let imageY:CGFloat = 8
                let imageH:CGFloat = 21
                let icon = UIImageView(frame: CGRect(x: imageX, y: imageY, width: imageW, height: imageH))
                icon.image = item.image
                icon.tintColor = UIColor.clearColor()
                
                let textLabel = UILabel ()
                textLabel.frame = CGRectMake(0, 32, ScreenWidth / CGFloat(items.count), 49 - 32)
                textLabel.text = item.title
                textLabel.backgroundColor = UIColor.clearColor()
                textLabel.font = UIFont.systemFontOfSize(10)
                textLabel.textAlignment = NSTextAlignment.Center
                textLabel.textColor = UIColor.grayColor()
                textLabel.translatesAutoresizingMaskIntoConstraints = false
                container.addSubview(icon)
                container.addSubview(textLabel)
                
                if let tabBarItem = tabBar.items {
                    let textLabelWidth = tabBar.frame.size.width / CGFloat(tabBarItem.count)
                    textLabel.bounds.size.width = textLabelWidth
                }
                
                let iconsAndLabels = (icon:icon, textLabel:textLabel)
                iconsView.append(iconsAndLabels)
                
                item.image = nil
                item.title = ""
                
                if index == 0 {
                    selectedIndex = 0
                    selectItem(0)
                }
            }
        }
    }
    
    //重写父类的didSelectItem
    override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        setSelectIndex(from: selectedIndex, to: item.tag)
    }
    
    //选择item时item中内容的变化
    func selectItem(index: Int) {
        let items = tabBar.items as! [RAMAnimatedTabBarItem]
        let selectIcon = iconsView[index].icon
        selectIcon.image = UIImage(named: iconsSelectedImageName[index])!
        items[index].selectedState(selectIcon, textLabel: iconsView[index].textLabel)
    }
    
    //根据选择的index值设置item中的内容并且执行动画父类中的方法
    func setSelectIndex(from from: Int, to: Int) {
        
        selectedIndex = to
        let items = tabBar.items as! [RAMAnimatedTabBarItem]
        
        let fromIV = iconsView[from].icon
        fromIV.image = UIImage(named: iconsImageName[from])
        items[from].deselectAnimation(fromIV, textLabel: iconsView[from].textLabel)
        
        let toIV = iconsView[to].icon
        toIV.image = UIImage(named: iconsSelectedImageName[to])
        items[to].playAnimation(toIV, textLabel: iconsView[to].textLabel)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
