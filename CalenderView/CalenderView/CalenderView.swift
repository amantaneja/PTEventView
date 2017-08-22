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

protocol CalenderViewProtocol:class {
    func didTapCalenderView(height:CGFloat)
}

@IBDesignable
class CalenderView: UIView, UITableViewDataSource, UITableViewDelegate {

    /**
     Color of Event View
     */
    @IBInspectable open var eventColor: UIColor = UIColor.lightGray
   
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
        
        self.addEvent(startTime: startTime, startTimeZone: startTimeZone, eventName: eventName, endTime: endTime, endTimeZone: endTimeZone)
        
        eventTableView.register(UINib(nibName: "CalenderViewCell", bundle: nil), forCellReuseIdentifier: "CalenderViewCell")
        timeTableView.register(UINib(nibName: "CalenderViewCell", bundle: nil), forCellReuseIdentifier: "CalenderViewCell")
        
        self.eventTableView.frame = CGRect(origin: self.eventTableView.frame.origin, size: CGSize(width: self.eventTableView.frame.width, height: CGFloat((mymodel.count-1)*22)))
        self.timeTableView.frame = CGRect(origin: self.eventTableView.frame.origin, size: CGSize(width: self.eventTableView.frame.width, height: CGFloat((mymodel.count)*22)))
        
        
        self.addSubview(eventTableView)
        self.addSubview(timeTableView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapBlurButton(_:)))
        self.addGestureRecognizer(tapGesture)
    }

    func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

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
                returnCell.backgroundColor = eventColor
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

    @IBOutlet weak var majorViewHeightConstraint: NSLayoutConstraint!
    func tapBlurButton(_ sender: UITapGestureRecognizer) {
        self.layoutIfNeeded()
        
        if isClicked {
            majorViewHeightConstraint.constant = 132
            isClicked = false
        } else {
            majorViewHeightConstraint.constant = (self.eventTableView?.contentSize.height)!
            isClicked = true
        }
        
        UIView.animate(withDuration: 0.5, animations: {
            self.layoutIfNeeded()
        })
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
        
        if !endTimeZone.contains(.PM) && !startTimeZone.contains(.PM){
            
            for i in startTime.min()!-1..<endTime.max()!+2 {
                
                var valueDict = Dictionary<String,String>()
                valueDict["time"] = i.description + " AM"
                
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
        
        if endTimeZone.contains(.PM) && !startTimeZone.contains(.PM){
            for i in startTime.min()!-1..<13{
                var valueDict = Dictionary<String,String>()
                valueDict["time"] = i.description + "AM"
                
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
            
            
            for i in 1..<endTime.max()!+2{
                var valueDict = Dictionary<String,String>()
                valueDict["time"] = i.description + " PM"
                
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
        
        /* if startTimeZone[index] == .PM && endTimeZone[index] == .PM {
         for i in startTime[index]-1..<endTime[index]+2 {
         
         var valueDict = Dictionary<String,String>()
         valueDict["time"] = i.description + " PM"
         
         if i == startTime[index]{
         valueDict["eventName"] = eventName[index]
         } else{
         valueDict["eventName"] = ""
         }
         
         if i>=startTime[index] && i<endTime[index] {
         valueDict["event"] = " "
         } else{
         valueDict["event"] = ""
         }
         
         
         //mymodel[index].append(valueDict)
         }
         }*/
    }
}

