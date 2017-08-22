//
//  ViewController.swift
//  CalenderView
//
//  Created by Vinay Kharb on 8/18/17.
//  Copyright © 2017 Aman Taneja. All rights reserved.
//

import UIKit

class ViewController: UIViewController,CalenderViewProtocol {

    @IBOutlet weak var majorViewConstraint: NSLayoutConstraint!
    
    var mymodel = [Dictionary<String,String>]()
    var timesArray = [Int]()
    var eventsArray = [String]()
    @IBOutlet weak var myCalenderView: CalenderView!

    var isClicked: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       
        
        let calender = UIView.loadFromNibNamed("CalenderView", bundle: nil) as? CalenderView
        calender?.delegate = self
        calender?.setup(frame: myCalenderView.frame,startTime: [5,7], startTimeZone: [.AM,.AM], eventName: ["My Event","New"], endTime: [6,8], endTimeZone: [.AM,.AM])
        self.view.addSubview(calender!)
    
    }
    
    func didTapCalenderView(height: CGFloat) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
