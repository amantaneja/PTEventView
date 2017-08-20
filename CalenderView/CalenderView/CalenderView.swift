//
//  CalenderView.swift
//  CalenderView
//
//  Created by Vinay Kharb on 8/18/17.
//  Copyright © 2017 Aman Taneja. All rights reserved.
//

import UIKit

class CalenderView: UIView {

    @IBOutlet weak var timeTableView: UITableView!
    @IBOutlet weak var eventTableView: UITableView!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
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
