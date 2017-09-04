//
//  ViewController.swift
//  CalenderView
//
//  Created by Aman Taneja on 8/18/17.
//  Copyright © 2017 Aman Taneja. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var PTEventView: PTEventView!
    let events = [["5AM","9AM","WWDC KickOff"],["12AM","3PM","Swift Meetup '17"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let ptEventView = Bundle.main.loadNibNamed("PTEventView", owner: nil, options: nil)![0] as? PTEventView
        ptEventView?.delegate = self

        for event in events{
            
            let eventModel = PTEventViewModel()
            
            eventModel.startTime = event[0]
            eventModel.endTime = event[1]
            eventModel.eventName = event[2]
            ptEventView?.EventViewdataModel.append(eventModel)
        }
        
        ptEventView?.setup(frame: PTEventView.frame)
        self.view.addSubview(ptEventView!)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: PTEventViewProtocol {

    func willOpenPTEventView(height: CGFloat) {
        UIView.animate(withDuration: 0.4, animations: {
            self.heightConstraint.constant = height
            self.view.layoutIfNeeded()
            
        })
    }
    
    func willClosePTEventView(height: CGFloat) {
        UIView.animate(withDuration: 0.4, animations: {
            self.heightConstraint.constant = height
            self.view.layoutIfNeeded()
            
        })
    }
    
    func didClosePTEventView(height: CGFloat) {
        print("Closed")
    }
    
    func didOpenPTEventView(height: CGFloat) {
        print("Opened")
    }
    
}
