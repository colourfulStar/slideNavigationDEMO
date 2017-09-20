//
//  NavScrollView.swift
//  slideNavigationDemo
//
//  Created by zhangqq on 2017/9/15.
//  Copyright © 2017年 zhangqq. All rights reserved.
//

import UIKit

//定义代理，来控制主内容页的scrollview的滑动
protocol NavScrollViewDelegate {
    func setMainScrollViewContentOffset(i:CGFloat)
}

class NavScrollView: UIScrollView {
    
    var navBtnArrs = [UIButton]()
    var navBtnTitlesArrs = NSMutableArray()//所有button的标题数组
    var navBtnTagsArr = [NSInteger]()//所有button的tag值数组
    var navBtnWidth = NSInteger()
    var btnsCounts = NSInteger()
    
    //当前选中的
    var currentIndex = NSInteger()
    var currentBtn = UIButton()
    var lineView = UIView()
    
    var navScrollDelegate:NavScrollViewDelegate?
    
    
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        self.backgroundColor = UIColor.clear
        self.bounces = false
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.isPagingEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func loadView() -> () {
        for i in 0..<btnsCounts{
            
            let btnX = (self.frame.width / CGFloat(btnsCounts) - CGFloat(navBtnWidth))/2 + CGFloat(i) * self.frame.width/CGFloat(btnsCounts)
            
            let navBtn = UIButton()
            navBtn.frame = CGRect(x: btnX, y: 0, width: CGFloat(navBtnWidth), height: 44)
            navBtn.backgroundColor = UIColor.white
            navBtn.titleLabel?.font = UIFont .systemFont(ofSize: 14)
            navBtn.tag = 100 + i
            navBtn.setTitle(navBtnTitlesArrs[i] as? String, for: .normal)
            navBtn.addTarget(self, action: #selector(btnAction), for: .touchUpInside)
            
            currentIndex = navBtn.tag
            if currentIndex == 100 {
                navBtn.setTitleColor(UIColor.orange, for: .normal)
                currentBtn = navBtn
            }else{
                navBtn.setTitleColor(UIColor.lightGray, for: .normal)
            }
            
            navBtnTagsArr.append(navBtn.tag)
            navBtnArrs.append(navBtn)
            
            self .addSubview(navBtn)
        }
        
        
        lineView.frame = CGRect(x: (self.frame.width / CGFloat(btnsCounts) - CGFloat(navBtnWidth))/2, y:CGFloat(42) , width: CGFloat(navBtnWidth) , height: CGFloat(2))
        lineView.backgroundColor = UIColor.orange
        self.addSubview(lineView)
    }
    
    
    
    //MARK: - action
    func btnAction(button:UIButton){
        let tag = button.tag
        currentIndex = tag
        
        if tag == 100 {
            addAnimationAtFirst()
            navScrollDelegate?.setMainScrollViewContentOffset(i: 0)
            
        }else{
            addAnimationWithTag(tag: tag)
            navScrollDelegate?.setMainScrollViewContentOffset(i: CGFloat(tag - 100) * UIScreen.main.bounds.width)
            
        }
        currentBtn.setTitleColor(UIColor.lightGray, for: .normal)
        button.setTitleColor(UIColor.orange, for: .normal)
        currentBtn = button
    }
    
    
    func scrollTheViewAtIndex(index:NSInteger) -> () {
        if navBtnArrs.count > 0 && index >= 0 && index < navBtnArrs.count{
            for i in 0..<navBtnArrs.count
            {
                var otherBtn = UIButton()
                
                if navBtnTagsArr[i] == navBtnTagsArr[index] {
                    currentBtn = navBtnArrs[index]
                    currentBtn.setTitleColor(UIColor.orange, for: .normal)
                    
                }else{
                    otherBtn = navBtnArrs[i]
                    otherBtn.setTitleColor(UIColor.lightGray, for: .normal)
                }
                addAnimationWithTag(tag: index + 100)
            }
        }
    }
    
    //MARK: - Animation
    func addAnimationAtFirst() {
        UIView.animate(withDuration: 0.5, animations: {
            self.lineView.frame = CGRect(x: (self.self.frame.width / CGFloat(self.btnsCounts) - CGFloat(self.navBtnWidth))/2, y:CGFloat(42) , width: CGFloat(self.navBtnWidth) , height: CGFloat(2))
        })
    }
    
    func addAnimationWithTag(tag:NSInteger) {
        UIView.animate(withDuration: 0.5, animations: {
            self.lineView.frame = CGRect(x: (self.self.frame.width / CGFloat(self.btnsCounts) - CGFloat(self.navBtnWidth))/2 + CGFloat(tag - 100) * CGFloat(self.self.frame.width/CGFloat(self.btnsCounts)) , y:CGFloat(42) , width: CGFloat(self.navBtnWidth) , height: CGFloat(2))
        })
    }
}
