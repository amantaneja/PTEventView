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
    @IBOutlet weak var majorView: UIView!
    @IBOutlet weak var eventTable: UITableView!
    @IBOutlet weak var timeTableView: UITableView!
    
    var mymodel = [Dictionary<String,String>]()
    var model:CalenderModel?
    var timesArray = [Int]()
    var eventsArray = [String]()

    var isClicked: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        majorView.layer.cornerRadius = 6.0
        majorView.layer.borderColor = UIColor.darkGray.cgColor
        majorView.layer.borderWidth = 1.0
        majorView.clipsToBounds = true
        
        self.addEvent(startTime: [8,10], startTimeZone: [.AM,.AM], eventName: ["My Event", "New Event"], endTime: [9,12], endTimeZone: [.AM,.AM,])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapBlurButton(_:)))
        majorView.addGestureRecognizer(tapGesture)
    }

    func tapBlurButton(_ sender: UITapGestureRecognizer) {
        view.layoutIfNeeded()
        
        if isClicked {
            majorViewConstraint.constant = 132
            isClicked = false
        } else {
            majorViewConstraint.constant = self.eventTable.contentSize.height
            isClicked = true
        }
        
        
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


extension ViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == self.eventTable {
            return mymodel.count-1
        } else {
            return mymodel.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var returnCell = UITableViewCell()
    
        var cellModel = mymodel[indexPath.row]
        
        if tableView == self.eventTable {
            returnCell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath)
            let labelEventNames = returnCell.viewWithTag(100) as! UILabel
            
            if cellModel["event"] != "" {
                labelEventNames.text = cellModel["eventName"]
                returnCell.backgroundColor = UIColor(red: 74/255, green: 181/255, blue: 248/255, alpha: 1)
                labelEventNames.textColor = UIColor.white
            } else{
                labelEventNames.text = ""
                returnCell.backgroundColor = UIColor(red: 243/255, green: 243/255, blue: 243/255, alpha: 1)
            }
        
        } else if tableView == self.timeTableView{
            returnCell = tableView.dequeueReusableCell(withIdentifier: "TimeCell", for: indexPath)
            let labelEventNames = returnCell.viewWithTag(200) as! UILabel
            
            labelEventNames.font = UIFont.helveticaMedium(9)
            labelEventNames.textColor = UIColor.lightGray
            returnCell.backgroundColor = UIColor(red: 243/255, green: 243/255, blue: 243/255, alpha: 1)
            
            labelEventNames.text = cellModel["time"]!
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

extension ViewController {
    func addEvent(startTime:[Int] = [12],startTimeZone:[timeZone] = [timeZone.AM], eventName: [String] = [""], endTime:[Int] = [5], endTimeZone: [timeZone] = [timeZone.AM]) {
        
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
        
        if startTimeZone.contains(.PM) && endTimeZone.contains(.PM){
        
        }
        
        /*if startTimeZone[index] == .AM && endTimeZone[index] == .PM{
            
            for i in startTime[index]-1..<13{
                var valueDict = Dictionary<String,String>()
                valueDict["time"] = i.description + "AM"
                
                if i == startTime[index]{
                    valueDict["eventName"] = eventName[index]
                } else{
                    valueDict["eventName"] = ""
                }
                
                if i>=startTime[index]{
                    valueDict["event"] = " "
                } else{
                    valueDict["event"] = ""
                }
               // mymodel[index].append(valueDict)
            }
            
            for i in 1..<endTime[index]+2{
                var valueDict = Dictionary<String,String>()
                valueDict["time"] = i.description + " PM"
            
                valueDict["eventName"] = ""
                
                if i<endTime[index] {
                    valueDict["event"] = " "
                } else {
                    valueDict["event"] = ""
                }
                
                //mymodel[index].append(valueDict)
            }
            
        }
        
        if startTimeZone[index] == .PM && endTimeZone[index] == .PM {
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
