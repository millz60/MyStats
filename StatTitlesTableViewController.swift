//
//  StatTitlesTableViewController.swift
//  MyStats
//
//  Created by Matt Milner on 8/7/16.
//  Copyright © 2016 Matt Milner. All rights reserved.
//

import UIKit

class StatTitlesTableViewController: UITableViewController, StatViewDelegate {
    
    var statTitle: String!
    var statNames: [String:Int]!
    var selectedStatName: String!
    var selectedStatAmount: String!
    
    func statValue(name:String, value: Int) {
        

        
        self.statNames[name] = value
        
        print(value)
        let defaults = NSUserDefaults.standardUserDefaults()
        let statsNames = defaults.valueForKey(statTitle)
        
        let newDict = [name:Int(value)]
        defaults.setObject(newDict, forKey: statTitle)
        
        
        
        print(statsNames)
        
        
        
        self.tableView.reloadData()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        self.tableView.reloadData()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = self.statTitle!
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let statsNames = defaults.valueForKey(statTitle)
        
        if (statsNames == nil) {
            self.statNames = [String:Int]()
            
        } else {
            
            self.statNames = statsNames!.mutableCopy() as! [String:Int]
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
        // #warning Incomplete implementation, return the number of rows
        return self.statNames.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("StatTitleCell", forIndexPath: indexPath)

        let defaults = NSUserDefaults.standardUserDefaults()
        let statsNames = defaults.valueForKey(statTitle)
        
        cell.backgroundColor = UIColor.clearColor()
        cell.textLabel?.textColor = UIColor.blackColor()
        
        let keys = statsNames?.allKeys
        let values = statsNames?.allValues
        cell.textLabel?.text = keys![indexPath.row] as! String
        cell.detailTextLabel?.text = String(values![indexPath.row])
        
        
        return cell
    }

    
    @IBAction func addCategory(){
        
        let alertController = UIAlertController(title: "Enter Stat Name", message: "", preferredStyle: .Alert)
        
        alertController.addTextFieldWithConfigurationHandler { (textField: UITextField) in
            textField.placeholder = "Stat Name"
        }
        
        let submitAction = UIAlertAction(title: "Submit", style: .Default) { (UIAlertAction) in
            
            let statName = alertController.textFields![0].text!
            self.statNames[statName] = 0
            
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject(self.statNames, forKey: self.statTitle)
            self.tableView.reloadData()
            defaults.synchronize()
            
            
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (UIAlertAction) in }
        
        alertController.addAction(submitAction)
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
        self.tableView.reloadData()
        
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let newController = StatViewViewController()
        let newCell = self.tableView(tableView, cellForRowAtIndexPath: indexPath)

        
    }
//    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let selectedCell = tableView.indexPathForSelectedRow!
        let destination = segue.destinationViewController as! StatViewViewController
        let selectedCell2 = tableView.cellForRowAtIndexPath(selectedCell)
        destination.delegate = self
        destination.name = selectedCell2!.textLabel!.text!
        destination.statCounts = selectedCell2!.detailTextLabel!.text!

    }
    


  }
