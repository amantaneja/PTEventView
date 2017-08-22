//
//  ViewController.swift
//  CalenderView
//
//  Created by Vinay Kharb on 8/18/17.
//  Copyright © 2017 Aman Taneja. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var majorViewConstraint: NSLayoutConstraint!
    
    var mymodel = [Dictionary<String,String>]()
    var timesArray = [Int]()
    var eventsArray = [String]()

    var isClicked: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       
        
        if let calender = UIView.loadFromNibNamed("CalenderView", bundle: nil) as? CalenderView{
            calender.setup(startTime: [5], startTimeZone: [.AM], eventName: ["My Event"], endTime: [6], endTimeZone: [.AM])
        }
        

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
