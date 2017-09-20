//
//  ViewController.swift
//  slideNavigationDemo
//
//  Created by zhangqq on 2017/8/19.
//  Copyright © 2017年 zhangqq. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
 
    }

    
    @IBAction func openAction(_ sender: Any) {
        
        let scrollNavCtrl = ScrollNavViewController()
        
        let navCtrl = UINavigationController(rootViewController: scrollNavCtrl)

        self.show(navCtrl, sender: navCtrl)
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

