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
    
    /**
     Called before PTEventView is to be opened. Do all the constraint expanding changes in this method.
     - Parameter height: Returns height of PTEventView
     */
    @objc optional func willOpenPTEventView(height:CGFloat)
    
    /**
     Called after PTEventView is opened. Allows after expanding animations.
     - Parameter height: Returns height of PTEventView

     */
    @objc optional func didOpenPTEventView(height:CGFloat)
    
    /**
     Called before PTEventView is to be closed. Do all the constraint compressing changes in this method.
     - Parameter height: Returns height of PTEventView

     */
    @objc optional func willClosePTEventView(height:CGFloat)
    
    /**
     Called after PTEventView is closed. Allows after compressing animations.
     - Parameter height: Returns height of PTEventView

     */
    @objc optional func didClosePTEventView(height:CGFloat)
    
    /**
     Called if the data is not in the correct format. You can choose to hide PTEventView in this method.
     */
    @objc optional func didReceiveErrorWhilePlottingEventView()
}
