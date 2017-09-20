//
//  ScrollNavViewController.swift
//  slideNavigationDemo
//
//  Created by zhangqq on 2017/8/19.
//  Copyright © 2017年 zhangqq. All rights reserved.
//

import UIKit

class ScrollNavViewController: UIViewController,UIScrollViewDelegate,NavScrollViewDelegate {
    
    /*
     *内容部分
     */
    var mainScrollView = UIScrollView()
    var pagesCounts = NSInteger()
    
    /*
     *导航栏部分
     */
    let scrolledNav = NavScrollView()
    
    /*
     *说明：
     * navBtnTitlesArrs：请设置导航栏上的每个按钮标题
     *请实现方法：func scrollTheViewAtIndex(index:NSInteger) -> ()
     *和实现代理方法：func setMainScrollViewContentOffset(i:CGFloat)
     */

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        UINavigationBar.appearance().barTintColor = UIColor.white
        
        scrolledNav.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 200, height: 44)
        scrolledNav.navBtnTitlesArrs = ["查看","管理"]
        pagesCounts = scrolledNav.navBtnTitlesArrs.count
        scrolledNav.navBtnWidth = 60
        scrolledNav.btnsCounts = pagesCounts
        scrolledNav.navScrollDelegate = self
        self.navigationItem.titleView = scrolledNav
        scrolledNav .loadView()
        
        createMainScrollViewWithPages(counts: pagesCounts)
    }
    

    
    func createMainScrollViewWithPages(counts:NSInteger) {
        
        mainScrollView.frame = CGRect(x: 0, y: 64, width:self.view.frame.width , height: self.view.frame.height - 64)
        mainScrollView.contentSize = CGSize(width: self.view.frame.width * CGFloat(counts) , height: 0)
        mainScrollView.showsHorizontalScrollIndicator = false
        mainScrollView.backgroundColor = UIColor.clear
        mainScrollView.bounces = false
        mainScrollView.isPagingEnabled = true
        mainScrollView.delegate = self 
        
        for i in 0..<counts {
            let contentLabel = UILabel()
            contentLabel.frame = CGRect(x: CGFloat(i) * self.view.frame.size.width , y: 100, width: self.view.frame.size.width, height: 20)
            contentLabel.backgroundColor = UIColor.clear
            contentLabel.textAlignment = NSTextAlignment.center
            contentLabel.text = "This is Page" + String(i+1)
            mainScrollView .addSubview(contentLabel)
        }
        
        self.view .addSubview(mainScrollView)
    }
    
    
    
    //MARK: - UIScrollViewDelegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView){
        let currentPage = NSInteger( mainScrollView.contentOffset.x / mainScrollView.bounds.size.width)
        scrolledNav.scrollTheViewAtIndex(index: currentPage)
    }
    
    
    //MARK: - NavScrollViewDelegate
    func setMainScrollViewContentOffset(i:CGFloat){
        mainScrollView.setContentOffset(CGPoint(x:i ,y:-64), animated: true)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
