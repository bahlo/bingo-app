//
//  HistoryController.swift
//  Bingo
//
//  Created by Arne Bahlo on 18/09/15.
//  Copyright © 2015 Arne Bahlo. All rights reserved.
//

import UIKit
import CoreData

class HistoryController: UITableViewController {
    
    var items: [Number]?

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        items = fetchItems()
    }


    // MARK: CoreData
    
    func fetchItems() -> [Number] {
        let delegate = UIApplication.sharedApplication().delegate
            as! AppDelegate
        let managedObjectContext = delegate.managedObjectContext
        
        var result: [Number]
        do {
            let request = NSFetchRequest(entityName: "Number")
            result = try managedObjectContext
                .executeFetchRequest(request) as! [Number]
        } catch let error as NSError {
            let alert = UIAlertController(title: "Error", message: "\(error)",
                preferredStyle: UIAlertControllerStyle.Alert)
            self.presentViewController(alert, animated: true, completion: nil)
            
            return []
        }
        
        return result
    }
    
    func resetItems() {
        let delegate = UIApplication.sharedApplication().delegate
            as! AppDelegate
        let managedObjectContext = delegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Number")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try managedObjectContext.executeRequest(deleteRequest)
            items = []
        } catch let error as NSError {
            let alert = UIAlertController(title: "Error", message: "\(error)",
                preferredStyle: UIAlertControllerStyle.Alert)
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: TableView
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items!.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let number = items![indexPath.item]
        let cell = tableView.dequeueReusableCellWithIdentifier("NumberCell")!
        cell.textLabel!.text = "\(number.value)"
        cell.detailTextLabel!.text = "\(number.generatedAt)"
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            let delegate = UIApplication.sharedApplication().delegate
                as! AppDelegate
            let managedObjectContext = delegate.managedObjectContext
            
            managedObjectContext.deleteObject(items![indexPath.item])
            delegate.saveContext()
            items!.removeAtIndex(indexPath.item)
            
            tableView.reloadData()
        }
    }
    
    // MARK: View
    
    override func viewDidLoad() {
        self.tableView.allowsMultipleSelectionDuringEditing = false
    }
    
    // MARK: IB stuff
    
    @IBAction func resetButtonPressed(sender: UIBarButtonItem) {
        resetItems()
        tableView.reloadData()
    }
    
    
    @IBAction func doneButtonPressed(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
