//
//  MainPageViewController.swift
//  Sample
//
//  Created by Watanabe Takehiro on 2018/03/02.
//  Copyright © 2018年 Watanabe Takehiro. All rights reserved.
//

import UIKit

class MainPageViewController: UIPageViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 初期画面の設定
        self.setViewControllers([self.getFirst()], direction: .forward, animated: true, completion: nil)
        self.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    fileprivate func getFirst() -> FirstViewController {
        return self.storyboard!.instantiateViewController(withIdentifier: "FirstViewController") as! FirstViewController
    }
    
    fileprivate func getSecond() -> SecondViewController {
        return self.storyboard!.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
    }
    
    fileprivate func getThird() -> ThirdViewController {
        return self.storyboard!.instantiateViewController(withIdentifier: "ThirdViewController") as! ThirdViewController
    }
    
}

extension MainPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if viewController.isKind(of: FirstViewController.self){
            return nil
        } else if viewController.isKind(of: SecondViewController.self) {
            return self.getFirst()
        } else {
            return self.getSecond()
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if viewController.isKind(of: FirstViewController.self){
            return self.getSecond()
        } else if viewController.isKind(of: SecondViewController.self) {
            return self.getThird()
        } else {
            return nil
        }
    }
}

extension MainPageViewController: UIPageViewControllerDelegate {
    
}
