//
//  ViewController.swift
//  PagingViewController
//
//  Created by 山口 智生 on 2015/06/30.
//  Copyright (c) 2015年 NextVanguard. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let label = UILabel(frame: CGRectMake(0,0,300,50))
        label.backgroundColor = UIColor.orangeColor()
        label.text = "Application started"
        label.textAlignment = NSTextAlignment.Center
        label.textColor = UIColor.whiteColor()
        label.layer.position = self.view.center
        self.view.addSubview(label)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

