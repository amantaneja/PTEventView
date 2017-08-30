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

@objc public protocol CalenderViewProtocol {
    
    @objc optional func willOpenCalenderView(height:CGFloat)
    
    @objc optional func didOpenCalenderView(height:CGFloat)
    
    @objc optional func willCloseCalenderView(height:CGFloat)
    
    @objc optional func didCloseCalenderView(height:CGFloat)
}

