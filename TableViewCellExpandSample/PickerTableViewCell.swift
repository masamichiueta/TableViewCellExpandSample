//
//  PickerTableViewCell.swift
//  TableViewCellExpandSample
//
//  Created by UetaMasamichi on 2015/07/05.
//  Copyright © 2015年 Masamichi Ueta. All rights reserved.
//

import UIKit

class PickerTableViewCell: UITableViewCell {

    @IBOutlet weak var datePIcker: UIDatePicker!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
