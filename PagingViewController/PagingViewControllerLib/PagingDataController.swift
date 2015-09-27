//
//  PagingDataController.swift
//  PagingViewController
//
//  Created by 山口 智生 on 2015/07/02.
//  Copyright (c) 2015年 NextVanguard. All rights reserved.
//

import Foundation
import UIKit

class PagingDataController: NSObject, UIPageViewControllerDataSource {
    var pageData: [AnyObject] = []
    
    var pagingRootViewController: PagingViewController? = nil
    
    init(data: [AnyObject]) {
        super.init()
        self.pageData = data
    }
    
    
    func viewControllerAtIndex(index: Int) -> PagingCellViewController? {
        if (self.pageData.count == 0) || (index >= self.pageData.count) || (index < 0) {
            return nil
        }
        
        if let pagingCellViewController = instanciateViewControllerAtIndex(index) {
            pagingCellViewController.setDataObject(self.pageData[index])//dataObjectをセット
            pagingCellViewController.setIndex(index)//indexをセットしておく
            pagingCellViewController.delegate = self.pagingRootViewController
            return pagingCellViewController
        }
        return nil
    }
    
    //必ずオーバーライドさせる。indexに対応するViewController
    func instanciateViewControllerAtIndex(index: Int) -> PagingCellViewController? {
        return PagingCellViewController()
    }
    
    func indexOfViewController(viewController: PagingCellViewController) -> Int {
        if let index = viewController.getIndex() {
            return index
        } else {
            return NSNotFound
        }
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController as! PagingCellViewController)
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        index--
        return self.viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController as! PagingCellViewController)
        if index == NSNotFound {
            return nil
        }
        index++
        return self.viewControllerAtIndex(index)
    }
}