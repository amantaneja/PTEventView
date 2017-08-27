//
//  CalenderView.swift
//  CalenderView
//
//  Created by Vinay Kharb on 8/18/17.
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
     Color of Event View
     */
    @IBInspectable open var eventColor: UIColor = UIColor(red: 58/255, green: 181/255, blue: 244/255, alpha: 1)
        
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

    //TableViews for CalenderView
    @IBOutlet weak var eventTableView: UITableView!
    @IBOutlet weak var timeTableView: UITableView!
    
    //Calender View Protocol
    weak var delegate: CalenderViewProtocol?
    
    var singleTimeArray = [Dictionary<String,String>]()

    
    //Model for storing values
    var mymodel = [Dictionary<String,String>]()
    
    /**
     Is CalenderView Tapped
     */
    var isClicked: Bool = false
    
    /**
     Setup Calender View
     */
    func setup(frame: CGRect, startTime:[Int] = [12],startTimeZone:[timeZone] = [timeZone.AM], eventName: [String] = [""], endTime:[Int] = [5], endTimeZone: [timeZone] = [timeZone.AM]){
        
        self.frame = frame
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        self.clipsToBounds = true
        
        for i in 0..<startTime.count {
            var valuesDictionary = Dictionary<String,String>()
            
            valuesDictionary["startTime"] = startTime[i].description + " " + returnTimeZone(zone: startTimeZone[i])
            valuesDictionary["EndTime"] = endTime[i].description + " " + returnTimeZone(zone: endTimeZone[i])
            valuesDictionary["eventName"] = eventName[i]
            
            singleTimeArray.append(valuesDictionary)
        }
        
        
        self.addEvent(startTime: startTime, startTimeZone: startTimeZone, eventName: eventName, endTime: endTime, endTimeZone: endTimeZone)
        
        eventTableView.register(UINib(nibName: "CalenderViewCell", bundle: nil), forCellReuseIdentifier: "CalenderViewCell")
        timeTableView.register(UINib(nibName: "CalenderViewCell", bundle: nil), forCellReuseIdentifier: "CalenderViewCell")
        
        self.addSubview(eventTableView)
        self.addSubview(timeTableView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapBlurButton(_:)))
        self.addGestureRecognizer(tapGesture)
    }

    
    func returnTimeZone(zone:timeZone) -> String{
    
        if zone == timeZone.AM {
            return "AM"
        }
        else {
            return "PM"
        }
    }
 

    func tapBlurButton(_ sender: UITapGestureRecognizer) {
        
        self.layoutIfNeeded()
        
        
        
        UIView.animate(withDuration: 0.5, animations: {
            if self.isClicked {
                
                self.frame = CGRect(origin: self.frame.origin, size: CGSize(width: self.frame.size.width, height: 132))
                self.eventTableView.frame = CGRect(origin: self.eventTableView.frame.origin, size: CGSize(width: self.eventTableView.frame.width, height: 132))
                self.timeTableView.frame = CGRect(origin: self.timeTableView.frame.origin, size: CGSize(width: self.timeTableView.frame.width, height: 132))

                self.isClicked = false
            } else {
                
                self.frame = CGRect(origin: self.frame.origin, size: CGSize(width: self.frame.size.width, height: self.timeTableView.contentSize.height))
                self.eventTableView.frame = CGRect(origin: self.eventTableView.frame.origin, size: self.eventTableView.contentSize)
                self.timeTableView.frame = CGRect(origin: self.timeTableView.frame.origin, size: self.timeTableView.contentSize)
                
                self.isClicked = true
            }
            
            self.layoutIfNeeded()
        })
    }
}

extension CalenderView :UITabBarDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print(self.frame.size.width)
        print(self.timeTableView.contentSize.width)
        if tableView == self.eventTableView{
            return mymodel.count-1
        } else {
            return mymodel.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let returnCell = tableView.dequeueReusableCell(withIdentifier: "CalenderViewCell", for: indexPath) as! CalenderViewCell
        
        var cellModel = mymodel[indexPath.row]
        
        if tableView == self.eventTableView {
            
            if cellModel["event"] != "" {
                returnCell.cellLabel.text = cellModel["eventName"]
                returnCell.contentView.backgroundColor = eventColor
                returnCell.cellLabel.textColor = UIColor.white
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

extension CalenderView{
    class func RGBA(_ r : Int,g : Int,b : Int,a : CGFloat) -> UIColor{
        
        let red : CGFloat = CGFloat(r) / 255
        let green : CGFloat = CGFloat(g) / 255
        let blue : CGFloat = CGFloat(b) / 255
        
        return UIColor(red: red, green: green, blue: blue, alpha: a)
        
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
    func addEvent(startTime:[Int] = [12],startTimeZone:[timeZone] = [timeZone.AM], eventName: [String] = [""], endTime:[Int] = [5], endTimeZone: [timeZone] = [timeZone.AM]) {
        
        
        for i in startTime.min()!-1..<endTime.max()!+2 {
            
            var valueDict = Dictionary<String,String>()
            
            valueDict["time"] = i<13 ? i.description + " AM" : (i-12).description + " PM"
            
            if startTime.contains(i){
                let indexOfElement = startTime.index(of: i)
                valueDict["eventName"] = eventName[indexOfElement!]
            } else {
                valueDict["eventName"] = ""
            }
            
            if i>=startTime.first! && i<endTime.last!{
                for index in 0..<startTime.count{
                    
                    if i>=startTime[index] && i<endTime[index]{
                        valueDict["event"] = " "
                        break
                    } else {
                        valueDict["event"] = ""
                    }
                }
            } else {
                valueDict["event"] = ""
            }
            mymodel.append(valueDict)
        }
    }
}

