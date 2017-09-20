//
//  ScrollNavViewController.swift
//  slideNavigationDemo
//
//  Created by zhangqq on 2017/8/19.
//  Copyright © 2017年 zhangqq. All rights reserved.
//

import UIKit

class ScrollNavViewController: UIViewController,UIScrollViewDelegate {
    
    /*
     *导航栏部分
     */
    let kBtnWidth = 60
    
    var navScrollView = UIScrollView()
    
    var navWidth = CGFloat()
    
    //当前选中button的tag值
    var currentIndex = NSInteger()
    
    //当前选中button
    var currentBtn = UIButton()
    
    //当前选中button底部的横线
    var lineView = UIView()
    
    //所有button的tag值数组
    var navBtnTagsArr = [NSInteger]()
    
    
    /*
     *内容部分
     */
    var mainScrollView = UIScrollView()
    
    //分页的页数
    var pagesCounts = NSInteger()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        /*
         *说明：
         * pagesCounts：有几个分页；
         * names：每个分页的标题；
         * 以上参数可配置为你所需要的参数
         */
        navWidth = CGFloat(self.view.frame.width - 200)
        pagesCounts = 2
        
        UINavigationBar.appearance().barTintColor = UIColor.white
        
        self.navigationItem.titleView = createScrollNavCountsAndNames(counts: pagesCounts, names: ["查看","管理"])
        
        createMainScrollViewWithPages(counts: pagesCounts)
    }
    

    /*
     *创建可滑动导航栏
     */
    func createScrollNavCountsAndNames(counts:NSInteger,names:NSArray) ->UIScrollView {
        
        navScrollView.frame = CGRect(x: 0, y: 0, width: navWidth, height: 44)
        navScrollView.backgroundColor = UIColor.clear
        navScrollView.bounces = false
        navScrollView.showsVerticalScrollIndicator = false
        navScrollView.showsHorizontalScrollIndicator = false
        navScrollView.isPagingEnabled = true

        
        for i in 0..<counts{
            let btnX = (navWidth / CGFloat(counts) - CGFloat(kBtnWidth))/2 + CGFloat(i) * navWidth/CGFloat(counts)
            
            let navBtn = UIButton()
            navBtn.frame = CGRect(x: btnX, y: 0, width: CGFloat(kBtnWidth), height: 44)
            navBtn.backgroundColor = UIColor.white
            navBtn.titleLabel?.font = UIFont .systemFont(ofSize: 14)
            navBtn.tag = 100 + i
            navBtn.setTitle(names[i] as? String, for: .normal)
            navBtn.addTarget(self, action: #selector(btnAction), for: .touchUpInside)
        
            currentIndex = navBtn.tag
            if currentIndex == 100 {
                navBtn.setTitleColor(UIColor.orange, for: .normal)
                currentBtn = navBtn
            }else{
                navBtn.setTitleColor(UIColor.lightGray, for: .normal)
            }
            
            navBtnTagsArr.append(navBtn.tag)
            
            navScrollView .addSubview(navBtn)
        }
        
        
        lineView.frame = CGRect(x: (navWidth / CGFloat(counts) - CGFloat(kBtnWidth))/2, y:CGFloat(42) , width: CGFloat(kBtnWidth) , height: CGFloat(2))
        lineView.backgroundColor = UIColor.orange
        navScrollView .addSubview(lineView)
        
        
        return navScrollView
    }
    
    
    /*
     *创建主scrollView
     */
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
    
    
    //MARK: - action
        func btnAction(button:UIButton){
            let tag = button.tag
            currentIndex = tag
            
            if tag == 100 {
                
                UIView.animate(withDuration: 0.5, animations: {
                    self.lineView.frame = CGRect(x: (self.navWidth / CGFloat(self.pagesCounts) - CGFloat(self.kBtnWidth))/2, y:CGFloat(42) , width: CGFloat(self.kBtnWidth) , height: CGFloat(2))
                })
                
                mainScrollView .setContentOffset(CGPoint(x:0 ,y:-64), animated: true)
                
            }else{
                
                UIView.animate(withDuration: 0.5, animations: {
                    self.lineView.frame = CGRect(x: (self.navWidth / CGFloat(self.pagesCounts) - CGFloat(self.kBtnWidth))/2 + CGFloat(tag - 100) * CGFloat(self.navWidth/CGFloat(self.pagesCounts)) , y:CGFloat(42) , width: CGFloat(self.kBtnWidth) , height: CGFloat(2))
                })
                
                mainScrollView .setContentOffset(CGPoint(x:CGFloat(tag - 100) * self.view.frame.size.width ,y:-64), animated: true)
                
            }
            
            currentBtn.setTitleColor(UIColor.lightGray, for: .normal)
            button.setTitleColor(UIColor.orange, for: .normal)
            currentBtn = button
    }
    
    
    //MARK: - UIScrollViewDelegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView){
        
        var button = UIButton()
        let currentPage = NSInteger( mainScrollView.contentOffset.x / mainScrollView.bounds.size.width)
        
        if currentPage == 0 {
            
            button = navScrollView.viewWithTag(100) as! UIButton
            
            UIView.animate(withDuration: 0.5, animations: {
                self.lineView.frame = CGRect(x: (self.navWidth / CGFloat(self.pagesCounts) - CGFloat(self.kBtnWidth))/2, y:CGFloat(42) , width: CGFloat(self.kBtnWidth) , height: CGFloat(2))
            })
            
        }else{
            
            for i in 0..<navBtnTagsArr.count {
                let currentBtnTag = navBtnTagsArr[i]
                
                if currentBtnTag != 100 {
                    
                    if currentPage == currentBtnTag - 100  {
                        button = navScrollView.viewWithTag(currentBtnTag) as! UIButton
                        
                        UIView.animate(withDuration: 0.5, animations: {
                            self.lineView.frame = CGRect(x: (self.navWidth / CGFloat(self.pagesCounts) - CGFloat(self.kBtnWidth))/2 + CGFloat(currentBtnTag - 100) * CGFloat(self.navWidth/CGFloat(self.pagesCounts)) , y:CGFloat(42) , width: CGFloat(self.kBtnWidth) , height: CGFloat(2))
                        })
                        
                    }
                }
            }
 
        }
        
        
        currentBtn.setTitleColor(UIColor.lightGray, for: .normal)
        button.setTitleColor(UIColor.orange, for: .normal)
        currentBtn = button
    }
    
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
