//
//  PTEventView.swift
//  PTEventViewDemo
//
//  Created by Aman Taneja on 9/1/17.
//  Copyright © 2017 Aman Taneja. All rights reserved.
//

import UIKit

@IBDesignable
class PTEventView: UIView {
    
    /**
     Border Color of Calender View
     */
    @IBInspectable open var borderColor: UIColor = UIColor.darkGray  {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    /**
     Border Width of Calender View
     */
    @IBInspectable open var borderWidth: CGFloat = 1.0  {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    /**
     Corner Radius of Calender View
     */
    @IBInspectable open var cornerRadius: CGFloat = 6.0  {
        didSet {
            self.layer.cornerRadius = cornerRadius
            self.clipsToBounds = true
        }
    }
    
    /**
     TableViews for CalenderView
     */
    @IBOutlet weak var eventTableView: UITableView!
    @IBOutlet weak var timeTableView: UITableView!
    
    /**
     CalenderView Protocol
     */
    @IBOutlet open weak var delegate: PTEventViewProtocol?
    
    /**
     Model for Storing Values
     */
    var calenderModel = [Dictionary<String,String>]()
    
    /**
     Is CalenderView Tapped
     */
    var isClicked: Bool = false
    
    /**
     Color of Event View
     */
    var eventColor: UIColor = UIColor(red: 58/255, green: 181/255, blue: 244/255, alpha: 1)
    
    /**
     Color of Event Text Label
     */
    var eventTextColor: UIColor = UIColor.white
    
    fileprivate var startTimes = [Int]()
    
    fileprivate var endTimes = [Int]()
    
    fileprivate var events = [String]()
    
    
    var EventViewdataModel = [PTEventViewModel]()

    func setup(frame: CGRect){
        
        self.frame = frame
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        self.clipsToBounds = true
        
        setUpTableViewSize(isOpen: false)
        
        setupData()
        
        self.addEvent(startTimes: startTimes, endTimes: endTimes, eventNames: events)
        
        eventTableView.register(UINib(nibName: "PTEventViewCell", bundle: nil), forCellReuseIdentifier: "PTEventViewCell")
        timeTableView.register(UINib(nibName: "PTEventViewCell", bundle: nil), forCellReuseIdentifier: "PTEventViewCell")
        
        self.addSubview(eventTableView)
        self.addSubview(timeTableView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapBlurButton(_:)))
        self.addGestureRecognizer(tapGesture)
    }

    func setupData() {
        for event in EventViewdataModel {
            if event.startTime!.localizedCaseInsensitiveContains("AM") || event.startTime!.localizedCaseInsensitiveContains("A.M.") || event.startTime!.localizedCaseInsensitiveContains("A M") {
                if let number = Int(event.startTime!.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) {
                    startTimes.append(number)
                } else {
                    print("Incorrect Format")
                }
            } else {
                if let number = Int(event.startTime!.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) {
                    startTimes.append(number+12)
                } else {
                    print("Incorrect Format")
                }
            }
            
            if event.endTime!.localizedCaseInsensitiveContains("AM") || event.endTime!.localizedCaseInsensitiveContains("A.M.") || event.endTime!.localizedCaseInsensitiveContains("A M") {
                if let number = Int(event.endTime!.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) {
                    endTimes.append(number)
                } else {
                    print("Incorrect Format")
                }
            } else {
                if let number = Int(event.endTime!.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) {
                    endTimes.append(number+12)
                } else {
                    print("Incorrect Format")
                }
            }
            events.append(event.eventName!)
        }
    }

    func setUpTableViewSize(isOpen: Bool) {
        
        if isOpen {
            self.eventTableView.frame = CGRect(origin: self.eventTableView.frame.origin, size: self.eventTableView.contentSize)
            self.timeTableView.frame = CGRect(origin: self.timeTableView.frame.origin, size: self.timeTableView.contentSize)
            
        } else {
            self.timeTableView.frame = CGRect(origin: self.timeTableView.frame.origin, size: CGSize(width: self.timeTableView.frame.width, height: 132))
            
            self.eventTableView.frame = CGRect(origin: self.eventTableView.frame.origin, size: CGSize(width: self.frame.width-63, height: 132))
        }
    }

    func tapBlurButton(_ sender: UITapGestureRecognizer) {
        
        self.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.5, animations: {
            
            if self.isClicked {
                
                self.delegate?.willClosePTEventView!(height: 132)
                
                self.frame = CGRect(origin: self.frame.origin, size: CGSize(width: self.frame.size.width, height: 132))
                
                self.setUpTableViewSize(isOpen: false)
                self.isClicked = false
                
            } else {
                if self.timeTableView.contentSize.height == 0 {
                    return
                }
                self.delegate?.willOpenPTEventView!(height: self.timeTableView.contentSize.height)
                
                self.frame = CGRect(origin: self.frame.origin, size: CGSize(width: self.frame.size.width, height: self.timeTableView.contentSize.height))
                
                self.setUpTableViewSize(isOpen: true)
                self.isClicked = true
            }
            self.layoutIfNeeded()
            
        }) { (true) in
            if !self.isClicked {
                self.delegate?.didClosePTEventView!(height: 132)
            } else {
                if self.timeTableView.contentSize.height == 0 {
                    return
                } else {
                self.delegate?.didOpenPTEventView!(height: self.timeTableView.contentSize.height)
                }
            }
        }
    }
}

extension PTEventView : UITabBarDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == self.eventTableView{
            return calenderModel.count-1
        } else {
            return calenderModel.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let returnCell = tableView.dequeueReusableCell(withIdentifier: "PTEventViewCell", for: indexPath) as! PTEventViewCell
        
        var cellModel = calenderModel[indexPath.row]
        
        if tableView == self.eventTableView {
            
            if cellModel["event"] != "" {
                returnCell.cellLabel.text = cellModel["eventName"]
                returnCell.contentView.backgroundColor = eventColor
                returnCell.cellLabel.textColor = eventTextColor
            } else{
                returnCell.cellLabel.text = ""
                returnCell.backgroundColor = UIColor(red: 243/255, green: 243/255, blue: 243/255, alpha: 1)
            }
            
        } else if tableView == self.timeTableView{
            
            returnCell.cellLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 9.0)!
            returnCell.cellLabel.textColor = UIColor.lightGray
            returnCell.backgroundColor = UIColor(red: 243/255, green: 243/255, blue: 243/255, alpha: 1)
            
            returnCell.cellLabel.text = cellModel["time"]!
        }
        
        return returnCell
    }
}

extension PTEventView {
    func addEvent(startTimes: [Int], endTimes: [Int], eventNames: [String]) {
        
        if startTimes.count==0 || endTimes.count==0 {
            delegate?.didReceiveErrorWhilePlottingEventView?()
            return
        }
        for i in startTimes.min()!-1..<endTimes.max()!+2 {
            
            var valueDict = Dictionary<String,String>()
            
            if i==12 {
                valueDict["time"] = "Noon"
            } else {
                valueDict["time"] = i<13 ? i.description + " AM" : (i-12).description + " PM"
            }
            
            if startTimes.contains(i){
                let indexOfElement = startTimes.index(of: i)
                valueDict["eventName"] = eventNames[indexOfElement!]
            } else {
                valueDict["eventName"] = ""
            }
            
            if i>=startTimes.first! && i<endTimes.last!{
                for index in 0..<startTimes.count{
                    
                    if i>=startTimes[index] && i<endTimes[index]{
                        valueDict["event"] = " "
                        break
                    } else {
                        valueDict["event"] = ""
                    }
                }
            } else {
                valueDict["event"] = ""
            }
            calenderModel.append(valueDict)
        }
    }
}



