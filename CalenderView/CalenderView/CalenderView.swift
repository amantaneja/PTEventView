//
//  CalenderView.swift
//  CalenderView
//
//  Created by Aman Taneja on 8/18/17.
//  Copyright © 2017 Aman Taneja. All rights reserved.
//

import UIKit

enum timeZone:String
{
    case
    AM = "AM",
    PM = "PM"
}

@IBDesignable
class CalenderView: UIView{

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
    weak var delegate: CalenderViewProtocol?
    
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
    
    /**
     Setup Calender View
     - parameter frame:   The frame of Calender View.
     - parameter startime:   The JSON serialization reading options. `.AllowFragments` by default.
     - parameter opt:   The JSON serialization reading options. `.AllowFragments` by default.
     - parameter opt:   The JSON serialization reading options. `.AllowFragments` by default.
     - parameter opt:   The JSON serialization reading options. `.AllowFragments` by default.

     */
    func setup(frame: CGRect, startTime:[Int] = [12],startTimeZone:[timeZone] = [timeZone.AM], eventName: [String] = [""], endTime:[Int] = [5], endTimeZone: [timeZone] = [timeZone.AM]){
        
        self.frame = frame
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        self.clipsToBounds = true
        
        setUpTableViewSize(isOpen: false)
        
        setupData()
        
        self.addEvent(startTimes: startTimes, endTimes: endTimes, eventNames: events)
        
        eventTableView.register(UINib(nibName: "CalenderViewCell", bundle: nil), forCellReuseIdentifier: "CalenderViewCell")
        timeTableView.register(UINib(nibName: "CalenderViewCell", bundle: nil), forCellReuseIdentifier: "CalenderViewCell")
        
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
                
                self.delegate?.willCloseCalenderView!(height: 132)
                
                self.frame = CGRect(origin: self.frame.origin, size: CGSize(width: self.frame.size.width, height: 132))
                
                self.setUpTableViewSize(isOpen: false)
                self.isClicked = false
                
            } else {
                
                self.delegate?.willOpenCalenderView!(height: self.timeTableView.contentSize.height)
                
                self.frame = CGRect(origin: self.frame.origin, size: CGSize(width: self.frame.size.width, height: self.timeTableView.contentSize.height))
                
                self.setUpTableViewSize(isOpen: true)
                self.isClicked = true
            }
            self.layoutIfNeeded()
            
        }) { (true) in
            if !self.isClicked {
                self.delegate?.didCloseCalenderView!(height: 132)
            } else {
                self.delegate?.didOpenCalenderView!(height: self.timeTableView.contentSize.height)
            }
        }
    }
}

extension CalenderView :UITabBarDelegate, UITableViewDataSource {
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
        
        let returnCell = tableView.dequeueReusableCell(withIdentifier: "CalenderViewCell", for: indexPath) as! CalenderViewCell
        
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
            
            returnCell.cellLabel.font = UIFont.helveticaMedium(9)
            returnCell.cellLabel.textColor = UIColor.lightGray
            returnCell.backgroundColor = UIColor(red: 243/255, green: 243/255, blue: 243/255, alpha: 1)
            
            returnCell.cellLabel.text = cellModel["time"]!
        }
        
        return returnCell
    }
}

extension UIView{
    class func loadFromNibNamed(_ nibNamed: String, bundle : Bundle? = nil) -> UIView? {
        return UINib(
            nibName: nibNamed,
            bundle: bundle
            ).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }
}

extension UIFont{
    
    static func helveticaNeue(_ size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue", size: size)!
    }
    
    static func helveticaBold(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Helvetica-Bold", size: size)!
    }
    
    static func helveticaMedium(_ size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-Medium", size: size)!
    }
    
}

extension CalenderView {
    func addEvent(startTimes: [Int], endTimes: [Int], eventNames: [String]) {
        
        
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

