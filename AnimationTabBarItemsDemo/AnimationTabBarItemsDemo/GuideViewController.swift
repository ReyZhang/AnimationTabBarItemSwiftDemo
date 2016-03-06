//
//  GuideViewController.swift
//  AnimationTabBarItemsDemo
//
//  Created by 刘光军 on 16/3/5.
//  Copyright © 2016年 刘光军. All rights reserved.
//

import UIKit

class GuideViewController: BaseViewController {
    
    private var collectionView:UICollectionView?
    private var imageNames = ["guide_40_1", "guide_40_2", "guide_40_3", "guide_40_4"]
    private let cellIdentifier = "GuideCell"
    private var isHiddenNextButton = true
    private var pageController = UIPageControl(frame: CGRectMake(0, ScreenHeight - 50, ScreenWidth, 20))
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: .None)
        createCollectionView()
        createPageControll()
        // Do any additional setup after loading the view.
    }
    
    
    //MARK:- UICollectionView
    func createCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = ScreenBounds.size
        layout.scrollDirection = .Horizontal
        
        collectionView = UICollectionView(frame: ScreenBounds, collectionViewLayout: layout)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.pagingEnabled = true
        collectionView?.bounces = false
        collectionView?.registerClass(GuideCollectionViewCell.self , forCellWithReuseIdentifier: cellIdentifier)
        view.addSubview(collectionView!)
    }
    
    private func createPageControll() {
        pageController.numberOfPages = imageNames.count
        pageController.currentPage = 0
        view.addSubview(pageController)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension GuideViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageNames.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as! GuideCollectionViewCell
        cell.newImage = UIImage(named: imageNames[indexPath.row])
        if indexPath.row != imageNames.count - 1 {
            cell.setNextBtnHidden(true)
        }
        return cell
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        if scrollView.contentOffset.x == ScreenWidth * CGFloat(imageNames.count - 1) {
            let cell = collectionView?.cellForItemAtIndexPath(NSIndexPath(forRow: imageNames.count - 1, inSection: 0)) as! GuideCollectionViewCell
            cell.setNextBtnHidden(false)
            isHiddenNextButton = false
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        if scrollView.contentOffset.x != ScreenWidth * CGFloat(imageNames.count - 1) && !isHiddenNextButton && scrollView.contentOffset.x > ScreenWidth * CGFloat(imageNames.count - 2) {
            let cell = collectionView?.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: NSIndexPath(forRow: imageNames.count - 1, inSection: 0)) as! GuideCollectionViewCell
            cell.setNextBtnHidden(true)
            isHiddenNextButton = true
        }
        pageController.currentPage = Int(scrollView.contentOffset.x / ScreenWidth + 0.5)
    }
}


