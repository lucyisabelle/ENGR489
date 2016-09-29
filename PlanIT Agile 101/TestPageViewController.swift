//
//  TestPageViewController.swift
//  PlanIT Agile 101
//
//  Created by Lucy French on 12/09/16.
//  Copyright © 2016 Lucy French. All rights reserved.
//

import UIKit

class TestPageViewController: UIPageViewController {
    
    //TODO: Set this so it isn't hardcoded
    var moduleid = 1

    private(set) lazy var orderedViewControllers: [UIViewController] = {
        // The view controllers will be shown in this order
        //create the array of questions
        var moduletest = ModuleTest()
        moduletest.loadViews(self.moduleid)
        var viewControllers = [UIViewController]()
        //limiting questions to 10
        for index in 1...10 {
            var questionObject = moduletest.getQuestion(index)
            print("\(questionObject.optionA) and \(questionObject.multichoice)")
            if questionObject.multichoice {
                
                var viewController = self.newMultiViewController()
                viewControllers.append(viewController)
            }
                //else its not a multichoice question, and therefore a true/false or 2 value question
            else {
                var viewController = self.newSelectViewController()
                viewControllers.append(viewController)
                
            }
        }
        
       /* return [self.newColoredViewController("Multichoice"),
                self.newColoredViewController("Match"),
                self.newColoredViewController("Select")]*/
        return viewControllers
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        dataSource = self
        
        let moduletest = ModuleTest()
        moduletest.loadViews(self.moduleid)
        
        
        if let firstViewController = orderedViewControllers.first {
            
            for count in 0...orderedViewControllers.count-1 {
                if let viewController = orderedViewControllers[count] as? MultichoiceViewController {
                    print("count: \(count)")
                    let questionObject = moduletest.getQuestion(count+1)
                    viewController.setValues(questionObject)
                }
                else if let viewController = orderedViewControllers[count] as? SelectViewController {
                    let questionObject = moduletest.getQuestion(count+1)
                    viewController.setValues(questionObject)
                }
            }
            setViewControllers([firstViewController],
                               direction: .Forward,
                               animated: true,
                               completion: nil)
        }
    }
    
    private func newColoredViewController(title: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil) .
            instantiateViewControllerWithIdentifier("\(title)ViewController")
    }
    
    private func newMultiViewController() -> MultichoiceViewController {
        let viewController = UIStoryboard(name : "Main", bundle: nil).instantiateViewControllerWithIdentifier("MultichoiceViewController") as! MultichoiceViewController
        return viewController
        
    }
    
    private func newSelectViewController() -> SelectViewController {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("SelectViewController") as! SelectViewController
        return viewController
    }
     
    
}
    // MARK: UIPageViewControllerDataSource
    
    extension TestPageViewController: UIPageViewControllerDataSource {
        
        func pageViewController(pageViewController: UIPageViewController,
                                viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
            guard let viewControllerIndex = orderedViewControllers.indexOf(viewController) else {
                return nil
            }
            
            let previousIndex = viewControllerIndex - 1
            
            // User is on the first view controller and swiped left to loop to
            // the last view controller.
            guard previousIndex >= 0 else {
                return orderedViewControllers.last
            }
            
            guard orderedViewControllers.count > previousIndex else {
                return nil
            }
            
            return orderedViewControllers[previousIndex]
        }
        
        func pageViewController(pageViewController: UIPageViewController,
                                viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
            guard let viewControllerIndex = orderedViewControllers.indexOf(viewController) else {
                return nil
            }
            
            let nextIndex = viewControllerIndex + 1
            let orderedViewControllersCount = orderedViewControllers.count
            
            // User is on the last view controller and swiped right to loop to
            // the first view controller.
            guard orderedViewControllersCount != nextIndex else {
                return orderedViewControllers.first
            }
            
            guard orderedViewControllersCount > nextIndex else {
                return nil
            }
            
            return orderedViewControllers[nextIndex]
        }
        
        func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
            return orderedViewControllers.count
        }
        
        func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
            guard let firstViewController = viewControllers?.first,
                firstViewControllerIndex = orderedViewControllers.indexOf(firstViewController) else {
                    return 0
            }
            
            return firstViewControllerIndex
        }
        
    }
    
   