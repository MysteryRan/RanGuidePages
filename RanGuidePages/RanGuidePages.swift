//
//  RanGuidePages.swift
//  RanGuidePages
//
//  Created by 浮生若梦 on 2017/5/15.
//  Copyright © 2017年 MysteryRan. All rights reserved.
//

import UIKit

class RanGuidePages: UIView, UIScrollViewDelegate {
    //图片数组
    fileprivate var imageDatas = [String]()
    
    //背景scrollerView
    fileprivate let scrollView = UIScrollView()
    
    //pageControl
    fileprivate let pageController = UIPageControl()
    
    //进入按钮
    fileprivate let actionButton = UIButton()
    
    //跳过按钮
    fileprivate let skipBtn = UIButton()
    
    //自动滚动时间
    var autoScrollTime = 2
    
    //重复次数
    var repeatTime: CGFloat = -1
    
    //自动滚动计时器
    fileprivate var autoTimer: Timer?
    
    // 重写初始化方法
    init(frame: CGRect, images: [String]) {
        
        super.init(frame: frame)
        
        imageDatas = images
        
        //MARK: 初始化UI
        initView()
        
        //MARK: 初始化timer
        initTimer()
    }
    
    func initTimer() {
        autoTimer = Timer.scheduledTimer(timeInterval: TimeInterval(autoScrollTime), target: self, selector: #selector(timerStart), userInfo: nil, repeats: true);
        autoTimer!.fire()
        RunLoop.current.add(autoTimer!, forMode: .common)
    }
    
    @objc func timerStart() {
        repeatTime += 1
        scrollView.contentOffset = CGPoint(x: repeatTime * UIScreen.main.bounds.width, y: 0)
        pageController.currentPage = Int((scrollView.contentOffset.x + UIScreen.main.bounds.width / 2.0) / UIScreen.main.bounds.width)
        if Int(repeatTime) >= imageDatas.count {
            self.removeFromSuperview()
            autoTimer?.invalidate()
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 初始化UI
    func initView() {
        //背景scrollView
        scrollView.frame = UIScreen.main.bounds
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width * CGFloat(imageDatas.count), height: UIScreen.main.bounds.height)
        scrollView.delegate = self
        scrollView.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        scrollView.bounces = false
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        addSubview(scrollView)
        
        //pageController
        pageController.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - 30, width: UIScreen.main.bounds.width, height: 10)
        pageController.numberOfPages = imageDatas.count
        pageController.currentPage = 0
        pageController.hidesForSinglePage = true
        pageController.pageIndicatorTintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        pageController.currentPageIndicatorTintColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        addSubview(pageController)
        
        //内容
        for i in 0..<imageDatas.count {
            //里面的图片
            let imageName = imageDatas[i]
            let imgView = UIImageView(image: UIImage.init(named: imageName))
            imgView.frame = CGRect(x: UIScreen.main.bounds.width * CGFloat(i), y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            imgView.isUserInteractionEnabled = true
            scrollView.addSubview(imgView)
            
            if i == imageDatas.count - 1 {
                //actionButton
                actionButton.frame = CGRect(x: UIScreen.main.bounds.width * 2.0 + UIScreen.main.bounds.width / 2.0 - 70, y: UIScreen.main.bounds.height - 70, width: 140, height: 35)
                actionButton.layer.cornerRadius = 5
                actionButton.layer.masksToBounds = true
                actionButton.setTitle("进入", for: .normal)
                actionButton.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
                actionButton.addTarget(self, action: #selector(BtnClick), for: .touchUpInside)
                scrollView.addSubview(actionButton)
            }
        }
        
        //跳过按钮
        skipBtn.frame = CGRect(x: UIScreen.main.bounds.width - 100, y: 30, width: 80, height: 35)
        skipBtn.layer.cornerRadius = 5
        skipBtn.layer.masksToBounds = true
        skipBtn.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.7896560977, blue: 0.7398188586, alpha: 1)
        skipBtn.setTitle("跳过", for: .normal)
        skipBtn.addTarget(self, action: #selector(skipGuard), for: .touchUpInside)
        self.addSubview(skipBtn)
        
    }
    
    //进入按钮点击事件
    @objc func BtnClick() {
        UIView.animate(withDuration: 2.0, animations: {
            self.alpha = 0.0
        }, completion: { (finish) in
            self.removeFromSuperview()
        })
    }
    
    //跳过按钮点击事件
    @objc func skipGuard() {
        UIView.animate(withDuration: 2.0, animations: {
            self.alpha = 0.0
        }, completion: { (finish) in
            self.removeFromSuperview()
        })
    }
    
    
    //MARK UIScrollViewDelegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageController.currentPage = Int((scrollView.contentOffset.x + UIScreen.main.bounds.width / 2.0) / UIScreen.main.bounds.width)
        if pageController.currentPage == imageDatas.count - 1 {
            skipBtn.isHidden = true
        } else {
            skipBtn.isHidden = false
        }
    }
}
