//
//  SettingsViewController.swift
//  TaskIt
//
//  Created by Krzysztof Kula on 17/06/15.
//  Copyright (c) 2015 Krzysztof Kula. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let kVersionNumber = "1.0"
    let kShouldCapitalizeTaskKey = "shouldCapitalizeTask"
    let kShouldCapitalizeNewTodoKey = "completeNewTodo"

    @IBOutlet weak var capitalizeTableView: UITableView!
    @IBOutlet weak var completeNewTodoTableView: UITableView!
    
    @IBOutlet weak var versionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.capitalizeTableView.delegate = self
        self.capitalizeTableView.dataSource = self
        self.capitalizeTableView.scrollEnabled = false
        
        self.completeNewTodoTableView.delegate = self
        self.completeNewTodoTableView.dataSource = self
        self.completeNewTodoTableView.scrollEnabled = false
        
        self.title = "Settings"
        self.versionLabel.text = kVersionNumber
        
        var doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("doneBarButtonItemPressed"))
        self.navigationItem.leftBarButtonItem = doneButton;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func doneBarButtonItemPressed(){
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    //UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell
        
        if tableView == self.capitalizeTableView {
            cell = tableView.dequeueReusableCellWithIdentifier("capitalizeCell") as! UITableViewCell
            if indexPath.row == 0 {
                cell.textLabel!.text = "No do not Capitalize"
                if NSUserDefaults.standardUserDefaults().boolForKey(kShouldCapitalizeTaskKey) == false {
                    cell.accessoryType = UITableViewCellAccessoryType.Checkmark
                }else{
                    cell.accessoryType = UITableViewCellAccessoryType.None
                }
                
            }else{
                cell.textLabel?.text = "Yes Capitalize!"
                
                if NSUserDefaults.standardUserDefaults().boolForKey(kShouldCapitalizeTaskKey) == true {
                    cell.accessoryType = UITableViewCellAccessoryType.Checkmark
                }else{
                    cell.accessoryType = UITableViewCellAccessoryType.None
                }
            }
        }else{
            cell = tableView.dequeueReusableCellWithIdentifier("completeNewTodoCell") as! UITableViewCell
            if indexPath.row == 0 {
                cell.textLabel?.text = "Do not complete Task"
                if NSUserDefaults.standardUserDefaults().boolForKey(kShouldCapitalizeNewTodoKey) == false {
                    cell.accessoryType = UITableViewCellAccessoryType.Checkmark
                }else{
                    cell.accessoryType = UITableViewCellAccessoryType.None
                }
            }else{
                cell.textLabel?.text = "Complete Task"
                if NSUserDefaults.standardUserDefaults().boolForKey(kShouldCapitalizeNewTodoKey) == true {
                    cell.accessoryType = UITableViewCellAccessoryType.Checkmark
                }else{
                    cell.accessoryType = UITableViewCellAccessoryType.None
                }
            }
            
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 30
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == self.capitalizeTableView {
            return "Capitalize new Task?"
        }else{
            return "Complete new Task?"
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if tableView == self.capitalizeTableView {
            if indexPath.row == 0 {
                NSUserDefaults.standardUserDefaults().setBool(false, forKey: kShouldCapitalizeTaskKey)
            }else{
                NSUserDefaults.standardUserDefaults().setBool(true, forKey: kShouldCapitalizeTaskKey)
            }
        }else{
            if indexPath.row == 0 {
                NSUserDefaults.standardUserDefaults().setBool(false, forKey: kShouldCapitalizeNewTodoKey)
            }else{
                NSUserDefaults.standardUserDefaults().setBool(true, forKey: kShouldCapitalizeNewTodoKey)
            }

        }
        
        NSUserDefaults.standardUserDefaults().synchronize()
        
        tableView.reloadData()
    }

}
