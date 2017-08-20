//
//  CalenderModel.swift
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

class CalenderModel: NSObject {
    
    var times = [Int]()
    
    init(startTime:Int = 12,startTimeZone:timeZone = timeZone.AM, eventName: String = "", endTime:Int = 5, endTimeZone: timeZone = timeZone.AM) {
        super.init()

        for i in startTime-1..<endTime+2 {
            times.append(i)
        }
    }
}
