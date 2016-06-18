//
//  SectionPageViewController.swift
//  PlanIT Agile 101
//
//  Created by Lucy French on 18/06/16.
//  Copyright © 2016 Lucy French. All rights reserved.
//

import UIKit

class SectionPageViewController: UIPageViewController, UIPageViewControllerDataSource {

    var viewControllersArray = [PageViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        // Do any additional setup after loading the view.
        viewControllersArray += [PageViewController()]
        viewControllersArray += [PageViewController()]
        viewControllersArray += [PageViewController()]
        let firstViewController = [viewControllersArray[1]]
        setViewControllers(firstViewController, direction: .Forward, animated: false, completion: nil) //TODO: add to completion
        
    }

    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        return viewControllersArray[0]
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        return viewControllersArray[2]
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
