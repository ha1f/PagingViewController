//
//  PageCellViewController.swift
//  PagingViewController
//
//  Created by 山口 智生 on 2015/07/02.
//  Copyright (c) 2015年 NextVanguard. All rights reserved.
//

import Foundation
import UIKit


protocol PagingViewControllerDelegate {
    func receiveMessage(message: String)
}

class PagingCellViewController: UIViewController {
    private var index: Int!//pageControllerの識別のため
    
    var delegate: PagingViewControllerDelegate! = nil
    
    //必ずオーバーライドする
    func setDataObject(dataObject: AnyObject?){
    }
    
    func sendMessageToRoot(message: String) {
        delegate.receiveMessage(message)
    }
    
    final func getIndex()->Int?{
        return self.index
    }
    final func setIndex(index: Int?){
        self.index = index
    }

}