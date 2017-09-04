//
//  CalenderViewDelegate.swift
//  CalenderView
//
//  Created by Aman Taneja on 8/26/17.
//  Copyright © 2017 Aman Taneja. All rights reserved.
//

import UIKit

/**
 Optional delegate that can be used to be notified whenever the user
 taps on a Calender View
 */

@objc protocol PTEventViewProtocol {
    
    @objc optional func willOpenPTEventView(height:CGFloat)
    
    @objc optional func didOpenPTEventView(height:CGFloat)
    
    @objc optional func willClosePTEventView(height:CGFloat)
    
    @objc optional func didClosePTEventView(height:CGFloat)
    
    @objc optional func didReceiveErrorWhilePlottingEventView()
}
