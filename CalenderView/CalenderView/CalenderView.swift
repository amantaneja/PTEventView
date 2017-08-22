//
//  CalenderView.swift
//  CalenderView
//
//  Created by Vinay Kharb on 8/18/17.
//  Copyright © 2017 Aman Taneja. All rights reserved.
//

import UIKit

class CalenderView: UIView {

    @IBOutlet weak var eventTableView: UITableView!
    @IBOutlet weak var timeTableView: UITableView!
    
    @IBOutlet weak var majorViewHeightConstraint: NSLayoutConstraint!
    var mymodel = [Dictionary<String,String>]()
    var timesArray = [Int]()
    var eventsArray = [String]()
    
    var isClicked: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }
    
    func setup(startTime:[Int] = [12],startTimeZone:[timeZone] = [timeZone.AM], eventName: [String] = [""], endTime:[Int] = [5], endTimeZone: [timeZone] = [timeZone.AM]){
        
        self.layer.cornerRadius = 6.0
        self.layer.borderColor = UIColor.darkGray.cgColor
        self.layer.borderWidth = 1.0
        self.clipsToBounds = true
        
        eventTableView.register(UINib(nibName: "CalenderViewCell", bundle: nil), forCellReuseIdentifier: "CalenderViewCell")
        timeTableView.register(UINib(nibName: "CalenderViewCell", bundle: nil), forCellReuseIdentifier: "CalenderViewCell")
        
        self.addEvent(startTime: startTime, startTimeZone: startTimeZone, eventName: eventName, endTime: endTime, endTimeZone: endTimeZone)
        
        self.eventTableView.delegate = self
        self.eventTableView.dataSource = self
        self.timeTableView.delegate = self
        self.timeTableView.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapBlurButton(_:)))
        self.addGestureRecognizer(tapGesture)
    }

    
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


extension CalenderView: UITableViewDataSource, UITableViewDelegate{
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
                returnCell.backgroundColor = UIColor(red: 74/255, green: 181/255, blue: 248/255, alpha: 1)
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

