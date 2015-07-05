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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if pickerIndexPath != nil {
            return 3
        }
        
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if pickerIndexPath != nil && indexPath.row == pickerIndexPath!.row {
            let cell = createPickerCell(NSDate())
            return cell
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")!
        cell.textLabel?.text = "Open Picker"
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
    
    
    func createPickerCell(date: NSDate) -> PickerTableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PickerCell") as! PickerTableViewCell
        cell.datePIcker.date = date
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
    
}
