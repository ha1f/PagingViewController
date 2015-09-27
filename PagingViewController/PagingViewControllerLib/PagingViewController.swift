//
//  PagingViewController.swift
//  PagingViewController
//
//  Created by 山口 智生 on 2015/07/02.
//  Copyright (c) 2015年 NextVanguard. All rights reserved.
//

import Foundation
import UIKit

class PagingViewController: UIViewController, UIPageViewControllerDelegate, PagingViewControllerDelegate {
    var pageViewController: UIPageViewController?
    var pageControl = UIPageControl()
    
    var pageData: [AnyObject] = []
    
    //設定項目
    var trasitionStyle = UIPageViewControllerTransitionStyle.Scroll
    var navigationOrientation = UIPageViewControllerNavigationOrientation.Horizontal
    
    //オーバーライドする
    func receiveMessage(message: String) {
        
    }
    
    var dataController: PagingDataController {
        if self._dataController == nil {
            self.setDataController(PagingDataController(data: self.pageData))
        }
        return self._dataController!
    }
    
    var _dataController: PagingDataController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setupWithDataController(dataController: PagingDataController) {
        self.pageData = dataController.pageData
        setDataController(dataController)
        self.createView()
    }
    
    //nilでなくても強制上書きするので注意
    func setDataController(dataController: PagingDataController) {
        self._dataController = dataController
        self._dataController!.pagingRootViewController = self
    }
    
    func createView(){
        self.pageViewController = UIPageViewController(transitionStyle: self.trasitionStyle, navigationOrientation: self.navigationOrientation, options: nil)
        self.pageViewController!.delegate = self
        
        let startingViewController = self.dataController.viewControllerAtIndex(0)!
        let viewControllers = [startingViewController]
        self.pageViewController!.setViewControllers(viewControllers, direction: .Forward, animated: false, completion: {done in })
        
        self.pageViewController!.dataSource = self.dataController
        
        self.addChildViewController(self.pageViewController!)
        self.view.addSubview(self.pageViewController!.view)
        
        //viewを作成
        var pageViewRect = self.view.bounds
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {//iPadのときは縁をつくる
            pageViewRect = CGRectInset(pageViewRect, 40.0, 40.0)
        }
        self.pageViewController!.view.frame = pageViewRect
        
        self.pageViewController!.didMoveToParentViewController(self)
        
        
        // PageControlを作成する.
        pageControl = UIPageControl(frame: CGRectMake(0, 50, self.view.frame.width, 50))
        pageControl.numberOfPages = self.pageData.count
        pageControl.currentPage = 0// 現在ページを設定
        pageControl.userInteractionEnabled = false
        self.view.addSubview(pageControl)
        
        
        self.view.gestureRecognizers = self.pageViewController!.gestureRecognizers
    }
    
    //画面の回転を検知
    func pageViewController(pageViewController: UIPageViewController, spineLocationForInterfaceOrientation orientation: UIInterfaceOrientation) -> UIPageViewControllerSpineLocation {
        if (orientation == .Portrait) || (orientation == .PortraitUpsideDown) || (UIDevice.currentDevice().userInterfaceIdiom == .Phone) {

            let currentViewController = self.pageViewController!.viewControllers![0]
            let viewControllers = [currentViewController]
            self.pageViewController!.setViewControllers(viewControllers, direction: .Forward, animated: true, completion: {done in })
            self.pageViewController!.doubleSided = false//trueなら表裏表示される
            return UIPageViewControllerSpineLocation.Min
        }
        
        // 見開きモード(viewControllersには2つ入る)
        let currentViewController = self.pageViewController!.viewControllers?[0] as! PagingCellViewController
        var viewControllers: [UIViewController]
        
        let indexOfCurrentViewController = self.dataController.indexOfViewController(currentViewController)
        if (indexOfCurrentViewController == 0) || (indexOfCurrentViewController % 2 == 0) {
            let nextViewController = self.dataController.pageViewController(self.pageViewController!, viewControllerAfterViewController: currentViewController)
            viewControllers = [currentViewController, nextViewController!]
        } else {
            let previousViewController = self.dataController.pageViewController(self.pageViewController!, viewControllerBeforeViewController: currentViewController)
            viewControllers = [previousViewController!, currentViewController]
        }
        self.pageViewController!.setViewControllers(viewControllers, direction: .Forward, animated: true, completion: {done in })
        
        return .Mid
    }
    
    //スワイプによるページ遷移前に呼ばれる
    func pageViewController(pageViewController: UIPageViewController, willTransitionToViewControllers pendingViewControllers: [UIViewController]) {
        beforePaging(self.getCurrentPageIndex(), to: self.dataController.indexOfViewController(pendingViewControllers[0] as! PagingCellViewController))
    }
    
    //スワイプによるページ遷移後に呼ばれる
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let from = (previousViewControllers[0] as! PagingCellViewController).getIndex()!
        let to = self.getCurrentPageIndex()
        afterPaging(from, to: to)
    }
    
    //ページ遷移アニメーション完了後
    func afterPaging(from: Int, to: Int) {
        self.pageControl.currentPage = self.getCurrentPageIndex() //その時のページをPageControlにセット
    }
    //ページ遷移アニメーション前
    func beforePaging(from: Int, to: Int) {
        //self.pageControl.currentPage = to //その時のページをPageControlにセット
    }
    
    func getCurrentViewControllers() -> [PagingCellViewController] {
        return self.pageViewController!.viewControllers! as! [PagingCellViewController]
    }
    func getCurrentViewController() -> PagingCellViewController {
        return self.getCurrentViewControllers()[0]
    }
    func getCurrentPageIndex() -> Int! {
        return self.dataController.indexOfViewController(getCurrentViewController())
    }
    
    //特定のページヘ移動
    func moveTargetPage(index: Int) {
        let targetPageIndex = index > 5 ? 5 : index
        let currentPageIndex = self.getCurrentPageIndex()
        if targetPageIndex != currentPageIndex {
            let preIndex = self.getCurrentPageIndex()
            let dataViewController: PagingCellViewController = self.dataController.viewControllerAtIndex(targetPageIndex)!
            let viewControllers: NSArray = NSArray(array: [dataViewController])
            let direction:UIPageViewControllerNavigationDirection = targetPageIndex > currentPageIndex ? UIPageViewControllerNavigationDirection.Forward : UIPageViewControllerNavigationDirection.Reverse
            self.beforePaging(preIndex, to: targetPageIndex)
            self.pageViewController?.setViewControllers(viewControllers as? [UIViewController], direction: direction, animated: true,
                completion: { (flag) -> Void in self.afterPaging(preIndex, to: targetPageIndex)} )
        }
    }
}