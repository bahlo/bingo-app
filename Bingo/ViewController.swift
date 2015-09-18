//
//  ViewController.swift
//  Bingo
//
//  Created by Arne Bahlo on 18/09/15.
//  Copyright © 2015 Arne Bahlo. All rights reserved.
//

import UIKit

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
        return min + Int(arc4random_uniform(UInt32(max - min)))
    }
    
    
    @IBAction func numberButtonPressed(sender: UIButton) {
        sender.setTitle("\(self.generateNumber(1, max: 128))",
            forState: .Normal)
    }
}

