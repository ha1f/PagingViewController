//
//  ImagePageCellLastViewController.swift
//  PagingViewController
//
//  Created by 山口 智生 on 2015/07/02.
//  Copyright (c) 2015年 NextVanguard. All rights reserved.
//

import Foundation
import UIKit


class ImagePageCellLastViewController: PagingCellViewController{
    private var startButton: UIButton!
    private var backgroundImageView: UIImageView!
    private var imagePath: String!
    
    //dataobjectのセット、要override
    override func setDataObject(dataObject: AnyObject?){
        if let tmpDataObject: AnyObject = dataObject {
            self.imagePath = tmpDataObject as! String
        }else{
            self.imagePath = "default.jpg"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundImageView = UIImageView(frame: self.view.bounds)
        self.view.addSubview(backgroundImageView)
        
        startButton = UIButton(frame: CGRectMake(0,0,100,100))
        startButton.layer.position = CGPointMake(self.view.bounds.width/2, self.view.bounds.height-100)
        startButton.backgroundColor = UIColor.orangeColor()
        startButton.setTitle("START", forState: UIControlState.Normal)
        startButton.addTarget(self, action: "clickedStart:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(startButton)
    }
    
    func clickedStart(sender: UIButton!) {
        sendMessageToRoot("start")
    }
    
    func updateImage() {
        if let path = imagePath {
            backgroundImageView.image = UIImage(named: path)
        }else{
            backgroundImageView.image = UIImage(named: "default.JPG")
        }
    }
    
    //Viewが表示される直前
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        updateImage()
    }
}