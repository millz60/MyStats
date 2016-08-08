//
//  StatCategoriesTableViewController.swift
//  MyStats
//
//  Created by Matt Milner on 8/7/16.
//  Copyright © 2016 Matt Milner. All rights reserved.
//

import UIKit

class StatCategoriesTableViewController: UITableViewController {
    
    var statCategories: [String]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let statNames = defaults.valueForKey("statCategories")
        
        if (statNames == nil) {
            self.statCategories = [String]()
            
        } else {
            
            self.statCategories = statNames!.mutableCopy() as! [String]
        }
        
        self.tableView.backgroundColor = UIColor.clearColor()
        let imageView = UIImageView(image: (UIImage(named: "statpic1.jpeg")))
        self.tableView.backgroundView = imageView
        


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.statCategories.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("StatNameCell", forIndexPath: indexPath)

        cell.backgroundColor = UIColor.clearColor()
        let defaults = NSUserDefaults.standardUserDefaults()
        let statCategoriesArray = defaults.valueForKey("statCategories") as! NSArray
        
        cell.textLabel?.text = statCategoriesArray[indexPath.row] as! String
    
        return cell
    }
    
    @IBAction func addCategory(){
        
        let alertController = UIAlertController(title: "Enter Stat Name", message: "", preferredStyle: .Alert)
        
        alertController.addTextFieldWithConfigurationHandler { (textField: UITextField) in
            textField.placeholder = "Stat Name"
        }
        
        let submitAction = UIAlertAction(title: "Submit", style: .Default) { (UIAlertAction) in
            
            let statName = alertController.textFields![0].text!
            self.statCategories.append(statName)
            
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject(self.statCategories, forKey: "statCategories")
            self.tableView.reloadData()
            defaults.synchronize()
            
            
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (UIAlertAction) in }
        
        alertController.addAction(submitAction)
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
        self.tableView.reloadData()
        

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let destination =  segue.destinationViewController as! StatTitlesTableViewController
        let selectedCell = tableView.indexPathForSelectedRow!
        
        destination.statTitle = self.statCategories[selectedCell.row]
        
        
        
    }
    
    
    

   
}
