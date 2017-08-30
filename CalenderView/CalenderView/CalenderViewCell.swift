//
//  CalenderViewCell.swift
//  CalenderView
//
//  Created by Vinay Kharb on 8/21/17.
//  Copyright © 2017 Aman Taneja. All rights reserved.
//

import UIKit

class CalenderViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var cellLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}


