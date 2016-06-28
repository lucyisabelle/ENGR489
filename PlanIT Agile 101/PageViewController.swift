//
//  PageViewController.swift
//  PlanIT Agile 101
//
//  Created by Lucy French on 28/06/16.
//  Copyright © 2016 Lucy French. All rights reserved.
//

import UIKit

class PageViewController: UIViewController {
    
    //var scrollView: UIScrollView!
    //var textView: UITextView!
    //@IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textView: UITextView!
    //@IBOutlet var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //create UITextView
        
        //scrollView = UIScrollView(frame: view.bounds)
        //textView = UITextView(frame: view.bounds)
        textView.text = "Hello"
        
        //scrollView.addSubview(textView)

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
