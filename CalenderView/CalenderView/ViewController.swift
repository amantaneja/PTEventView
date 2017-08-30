//
//  ViewController.swift
//  CalenderView
//
//  Created by Vinay Kharb on 8/18/17.
//  Copyright © 2017 Aman Taneja. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var myCalenderView: CalenderView!
    let events = [["5AM","9AM","WWDC KickOff"],["12AM","3PM","Swift Meetup '17"]]

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let calender = UIView.loadFromNibNamed("CalenderView", bundle: nil) as? CalenderView
        calender?.delegate = self
        
        for event in events{
            
            let eventModel = PTEventViewModel()
            
            eventModel.startTime = event[0]
            eventModel.endTime = event[1]
            eventModel.eventName = event[2]
            calender?.EventViewdataModel.append(eventModel)
        }
        
        calender?.setup(frame: myCalenderView.frame,startTime: [10,12], startTimeZone: [.AM,.AM], eventName: ["Swift Meetup '17","WWDC Kickoff"], endTime: [11,15], endTimeZone: [.AM,.AM])
        calender?.eventColor = UIColor.green
        calender?.eventTextColor = UIColor.black
        self.view.addSubview(calender!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: CalenderViewProtocol {
    
    func addCalenderEvents() {
        
    }
    
    func willOpenCalenderView(height: CGFloat) {
        UIView.animate(withDuration: 0.4, animations: {
            self.heightConstraint.constant = height
            self.view.layoutIfNeeded()

        })
    }
    
    func willCloseCalenderView(height: CGFloat) {
        UIView.animate(withDuration: 0.4, animations: {
            self.heightConstraint.constant = height
            self.view.layoutIfNeeded()

        })
    }
    
    func didCloseCalenderView(height: CGFloat) {
        
    }
    
    func didOpenCalenderView(height: CGFloat) {
        
    }

}
