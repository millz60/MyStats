//
//  StatViewViewController.swift
//  MyStats
//
//  Created by Matt Milner on 8/7/16.
//  Copyright © 2016 Matt Milner. All rights reserved.
//

import UIKit

protocol StatViewDelegate {
    func statValue(name: String, value: Int)
}

class StatViewViewController: UIViewController {
    
    
    @IBOutlet weak var statName: UILabel!
    @IBOutlet weak var statCount: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    var name: String!
    var statCounts: String!
    var delegate: StatViewDelegate!
    var originalValue: Double!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    
        self.statName.text = self.name
        self.statCount.text = self.statCounts
        
//        let defaults = NSUserDefaults.standardUserDefaults()
//        let statsNames = defaults.valueForKey(self.name) as! NSDictionary
        self.originalValue = Double(statCounts)
        self.stepper.value = Double(statCounts)!
        print(self.originalValue)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func stepperPressed() {
        
        if (stepper.value > self.originalValue){
            self.statCounts = String(Int(statCounts)! + 1)
            self.statCount.text = self.statCounts
            
        } else {
            self.statCounts = String(Int(statCounts)! - 1)
            self.statCount.text = self.statCounts
            
        }
        let defaults = NSUserDefaults.standardUserDefaults()
        let statsNames = defaults.valueForKey(self.name)
//        let statsValues = statsNames.mutableCopy()
        
        let newDict = [self.name:Int(self.statCounts)!]
        defaults.setObject(newDict, forKey: self.name)
        defaults.synchronize()
    
        
        self.delegate.statValue(self.statName.text!, value: Int(self.statCounts)!)
        
        
    }

}
