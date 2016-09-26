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
                print("Creating multichoice question")
                var a = questionObject.optionA
                var b = questionObject.optionB
                var c = questionObject.optionC
                var d = questionObject.optionD
                var answer = questionObject.answer
                
                var viewController = self.newMultiViewController()
                print(a)

                //viewController.buttonA.setTitle(a, forState: UIControlState.Normal)
                //viewController.buttonB?.setTitle(b, forState: UIControlState.Normal)
                //viewController.buttonC?.setTitle(c, forState: UIControlState.Normal)
                //viewController.buttonD?.setTitle(d, forState: UIControlState.Normal)
                //viewController.questionLabel?.text = answer
                print(index)
                //viewControllers[index-1] = viewController
                viewControllers.append(viewController)
            }
                //else its not a multichoice question, and therefore a true/false or 2 value question
            else {
                print("Creating truefalse question index = \(index)")
                var a = questionObject.optionA
                var b = questionObject.optionB
                var answer = questionObject.answer
                
                //var viewController = SelectViewController()
                var viewController = self.newColoredViewController("Select") as! SelectViewController 
                viewController.buttonA?.setTitle(a, forState: UIControlState.Normal)
                viewController.buttonB?.setTitle(b, forState: UIControlState.Normal)
                viewController.questionLabel?.text = answer
                //viewControllers[index] = viewController
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
            setViewControllers([firstViewController],
                               direction: .Forward,
                               animated: true,
                               completion: nil)
            for count in 0...orderedViewControllers.count-1 {
                if let viewController = orderedViewControllers[count] as? MultichoiceViewController {
                    let questionObject = moduletest.getQuestion(count+1)
                    viewController.setValues(questionObject)
                }
                else if let viewController = orderedViewControllers[count] as? SelectViewController {
                    let questionObject = moduletest.getQuestion(count+1)
                    viewController.setValues(questionObject)
                }
            }
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
    
   