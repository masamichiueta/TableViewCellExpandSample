//
//  ViewController.swift
//  TableViewCellExpandSample
//
//  Created by UetaMasamichi on 2015/07/05.
//  Copyright © 2015年 Masamichi Ueta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var pickerIndexPath: NSIndexPath?
    
    var dates: [NSDate] = [NSDate(), NSDate()]
    let dateFormatter = NSDateFormatter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate, PickerTableViewCellDelegate {
    
    //MARK: - UITableViewDataSource, UITableViewDelegate
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if pickerIndexPath != nil {
            return dates.count + 1
        }
        
        return dates.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if pickerIndexPath != nil && indexPath.row == pickerIndexPath!.row {
            let cell = createPickerCell(dates[indexPath.row - 1])
            return cell
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("DateCell") as! DateTableViewCell
        cell.titleLabel.text = "Date"
        cell.dateLabel.text = dateFormatter.stringFromDate(dates[indexPath.row])
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.beginUpdates()
        
        if pickerIndexPath != nil && pickerIndexPath!.row - 1 == indexPath.row {
            hideExistingPicker()
        } else {
            
            let newPickerIndexPath = calculateIndexPathForNewPicker(indexPath)
            if pickerIndexPath != nil {
                hideExistingPicker()
            }
            
            showNewPickerAtIndexPath(newPickerIndexPath)
            pickerIndexPath = newPickerIndexPath
            
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        tableView.endUpdates()
        
    }
    
    
    //MARK: - Helper Methods
    func createPickerCell(date: NSDate) -> PickerTableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PickerCell") as! PickerTableViewCell
        cell.datePicker.date = date
        cell.delegate = self
        return cell
        
    }
    
    func hideExistingPicker() {
        
        self.tableView.deleteRowsAtIndexPaths([pickerIndexPath!], withRowAnimation: .Fade)
        self.pickerIndexPath = nil
    }
    
    func calculateIndexPathForNewPicker(selectedIndexPath: NSIndexPath) -> NSIndexPath {
        
        let newIndexPath: NSIndexPath
        if pickerIndexPath != nil && pickerIndexPath!.row < selectedIndexPath.row {
            newIndexPath = NSIndexPath(forRow: selectedIndexPath.row, inSection: selectedIndexPath.section)
        } else {
            newIndexPath = NSIndexPath(forRow: selectedIndexPath.row + 1, inSection: selectedIndexPath.section)
        }
        
        return newIndexPath
    }
    
    func showNewPickerAtIndexPath(indexPath: NSIndexPath) {
        
        let pickerIndexPath = NSIndexPath(forRow: indexPath.row, inSection: indexPath.section)
        
        tableView.insertRowsAtIndexPaths([pickerIndexPath], withRowAnimation: .Fade)
    }
    
    //MARK: - PickerTableViewCellDeleagate
    func dateDidChange(date: NSDate) {
        
        if pickerIndexPath == nil {
            return
        }
        
        let parentCellIndexPath = NSIndexPath(forRow: pickerIndexPath!.row - 1, inSection: pickerIndexPath!.section)
        
        let parentCell = tableView.cellForRowAtIndexPath(parentCellIndexPath) as! DateTableViewCell
        dates[parentCellIndexPath.row] = date
        print(date)
        print(dates)
        parentCell.dateLabel.text = dateFormatter.stringFromDate(date)
        
        
    }
    
}
