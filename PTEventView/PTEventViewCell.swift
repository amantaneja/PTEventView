//
//  PTEventViewCellTableViewCell.swift
//  PTEventViewDemo
//
//  Created by Vinay Kharb on 9/1/17.
//  Copyright © 2017 Aman Taneja. All rights reserved.
//

import UIKit

class PTEventViewCell: UITableViewCell {

    @IBOutlet weak var cellLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
