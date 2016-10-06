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
    var correctCount = 0
    var incorrectCount = 0

    fileprivate(set) lazy var orderedViewControllers: [UIViewController] = {
        // The view controllers will be shown in this order
        //create the array of questions
        var moduletest = ModuleTest()
        moduletest.loadViews(self.moduleid)
        var viewControllers = [UIViewController]()
        //limiting questions to 10
        for index in 1...10 {
            var questionObject = moduletest.getQuestion(index)
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
    
    func test(correct: Bool){
        if correct {
            correctCount += 1
        } else {
            incorrectCount += 1
        }
        if incorrectCount == 3 {
            performSegue(withIdentifier: "testFinished", sender: nil)
        }
        goToNextPage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        dataSource = self
        
        let moduletest = ModuleTest()
        moduletest.loadViews(self.moduleid)
        
        
        if let firstViewController = orderedViewControllers.first {
            
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
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
    }
    
    fileprivate func newColoredViewController(_ title: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil) .
            instantiateViewController(withIdentifier: "\(title)ViewController")
    }
    
    fileprivate func newMultiViewController() -> MultichoiceViewController {
        let viewController = UIStoryboard(name : "Main", bundle: nil).instantiateViewController(withIdentifier: "MultichoiceViewController") as! MultichoiceViewController
        return viewController
        
    }
    
    fileprivate func newSelectViewController() -> SelectViewController {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SelectViewController") as! SelectViewController
        return viewController
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "testFinished"){
            let nextController = segue.destination as! ResultsViewController
            
            nextController.correctAnswers = correctCount
            nextController.incorrectAnswers = incorrectCount 
        }
    }
    
    
}
    // MARK: UIPageViewControllerDataSource
    
    extension TestPageViewController: UIPageViewControllerDataSource {
        
        func pageViewController(_ pageViewController: UIPageViewController,
                                viewControllerBefore viewController: UIViewController) -> UIViewController? {
            return nil
            guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
                return nil
            }
            return nil
            //return orderedViewControllers[viewControllerIndex]
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
        
        func pageViewController(_ pageViewController: UIPageViewController,
                                viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
                return nil
            }
            
            let nextIndex = viewControllerIndex + 1
            let orderedViewControllersCount = orderedViewControllers.count
            
            // User is on the last view controller and swiped right to loop to
            // the first view controller.
            guard orderedViewControllersCount != nextIndex else {
                performSegue(withIdentifier: "testFinished", sender: nil)
                return nil
            }
            
            guard orderedViewControllersCount > nextIndex else {
                return nil
            }
            
            return orderedViewControllers[nextIndex]
        }
        
        func presentationCount(for pageViewController: UIPageViewController) -> Int {
            return orderedViewControllers.count
        }
        
        func presentationIndex(for pageViewController: UIPageViewController) -> Int {
            guard let firstViewController = viewControllers?.first,
                let firstViewControllerIndex = orderedViewControllers.index(of: firstViewController) else {
                    return 0
            }
            
            return firstViewControllerIndex
        }
        
        func goToNextPage(){
            
            guard let currentViewController = self.viewControllers?.first else { return }
            
            guard let nextViewController = dataSource?.pageViewController( self, viewControllerAfter: currentViewController ) else { return }
            
            setViewControllers([nextViewController], direction: .forward, animated: false, completion: nil)
            
        }
        
    }
    
   
