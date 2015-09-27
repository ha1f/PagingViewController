//
//  ImagePageCellViewController.swift
//  PagingViewController
//
//  Created by 山口 智生 on 2015/07/02.
//  Copyright (c) 2015年 NextVanguard. All rights reserved.
//

import Foundation
import UIKit

class ImagePageCellViewController: PagingCellViewController{
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