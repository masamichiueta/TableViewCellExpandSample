//
//  PickerTableViewCell.swift
//  TableViewCellExpandSample
//
//  Created by UetaMasamichi on 2015/07/05.
//  Copyright © 2015年 Masamichi Ueta. All rights reserved.
//

import UIKit

@objc protocol PickerTableViewCellDelegate {
    
    func dateDidChange(date: NSDate)
    
}

class PickerTableViewCell: UITableViewCell, UIPickerViewDelegate {

    @IBOutlet weak var datePicker: UIDatePicker!
    weak var delegate: PickerTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func dateDidChange(sender: AnyObject) {
        
        delegate?.dateDidChange(datePicker.date)
        
    }

}
