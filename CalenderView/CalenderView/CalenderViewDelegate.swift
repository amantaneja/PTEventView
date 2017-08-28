//
//  CalenderViewDelegate.swift
//  CalenderView
//
//  Created by Vinay Kharb on 8/26/17.
//  Copyright © 2017 Aman Taneja. All rights reserved.
//

import UIKit


@objc public protocol CalenderViewProtocol {
    
    @objc optional func willOpenCalenderView(height:CGFloat)
    
    @objc optional func didOpenCalenderView(height:CGFloat)
    
    @objc optional func willCloseCalenderView(height:CGFloat)
    
    @objc optional func didCloseCalenderView(height:CGFloat)
}

