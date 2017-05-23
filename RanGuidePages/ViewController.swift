//
//  ViewController.swift
//  RanGuidePages
//
//  Created by 浮生若梦 on 2017/5/23.
//  Copyright © 2017年 MysteryRan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //没有登录过
        guard (UserDefaults.standard.value(forKey: "launched") != nil) else {
            let images = ["1.jpg","2.jpg","3.jpg"]
            let ranGuide = RanGuidePages(frame: UIScreen.main.bounds, images: images)
            self.view.addSubview(ranGuide)
            //登录过
            UserDefaults.standard.set("launch", forKey: "launched")
            return
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

