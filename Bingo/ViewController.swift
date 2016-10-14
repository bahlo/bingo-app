//
//  ViewController.swift
//  Bingo
//
//  Created by Arne Bahlo on 18/09/15.
//  Copyright © 2015 Arne Bahlo. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func generateNumber(min: Int, max: Int) -> Int {
        let num = min + Int(arc4random_uniform(UInt32(max - min)))
        
        // Search core data if we already had that number
        let delegate = UIApplication.sharedApplication().delegate
            as! AppDelegate
        let managedObjectContext = delegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Number")
        fetchRequest.predicate = NSPredicate(format: "value == %d", num)
        
        do {
            let count = try managedObjectContext
                .countForFetchRequest(fetchRequest)
            if count > 0 {
                return 0;
            }
        } catch {
            return 0
        }

        
        return num
    }
    
    func saveNumber(num: Int) {
        let delegate = UIApplication.sharedApplication().delegate
            as! AppDelegate
        let managedObjectContext = delegate.managedObjectContext
        
        let number = NSEntityDescription
            .insertNewObjectForEntityForName("Number",
                inManagedObjectContext: managedObjectContext) as! Number
        number.value = Int32(num)
        number.generatedAt = NSDate()
        delegate.saveContext()
    }
    
    @IBAction func numberButtonPressed(sender: UIButton) {
        var num = self.generateNumber(1, max: 75)
        
        // Try 100 times to generate another number
        for n in 1...100 {
            if num > 0 {
                break
            }

            print(n)
            num = self.generateNumber(1, max: 75)
        }

        self.saveNumber(num)
        sender.setTitle("\(num)", forState: .Normal)
    }
    
}

