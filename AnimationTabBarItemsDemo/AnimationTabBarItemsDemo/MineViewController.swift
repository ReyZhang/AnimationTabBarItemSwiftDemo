//
//  MineViewController.swift
//  AnimationTabBarItemsDemo
//
//  Created by 刘光军 on 16/3/5.
//  Copyright © 2016年 刘光军. All rights reserved.
//

import UIKit

class MineViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.greenColor()
        self.navigationItem.title = "我的"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
