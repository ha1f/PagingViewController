//
//  TutorialViewController.swift
//  PagingViewController
//
//  Created by 山口 智生 on 2015/07/01.
//  Copyright (c) 2015年 NextVanguard. All rights reserved.
//


import Foundation
import UIKit

class TutorialViewController: PagingViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        let data = ["pic1.jpg", "pic2.jpg", "pic3.jpg", "pic4.jpg", "pic5.jpg"]
        
        self.trasitionStyle = UIPageViewControllerTransitionStyle.Scroll
        self.navigationOrientation = UIPageViewControllerNavigationOrientation.Horizontal
        self.setupWithDataController(TutorialPageDataController(data: data))
        
        //ここより下にsuperView(全ての管理下のページの上に表示されるオブジェクト)を記述する
        
        //pageControlが不要な場合は、self.pageControl.removeFromSuperview()
    }
    
    //管理下のpageCellからのメッセージを受け取る
    override func receiveMessage(message: String) {
        if(message == "start") {
            self.performSegueWithIdentifier("finishTutorial", sender: nil)
        }
    }
    
}


class TutorialPageDataController: PagingDataController {
    override func instanciateViewControllerAtIndex(index: Int) -> PagingCellViewController? {
        let dataViewController: PagingCellViewController
        
        if index == (self.pageData.count-1) {
            dataViewController = ImagePageCellLastViewController()
        }else{
            dataViewController = ImagePageCellViewController()
        }
        
        return dataViewController
    }
}