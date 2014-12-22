//
//  ViewController.swift
//  TaskIt
//
//  Created by Krzysztof Kula on 21/12/14.
//  Copyright (c) 2014 Krzysztof Kula. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var taskArray:[[String:String]] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

        taskArray = [
            ["task":"Study French", "subtask":"Verbs",   "date": "14/01/2014"],
            ["task":"Eat Dinner",   "subtask":"Burgers", "date": "14/01/2014"],
            ["task":"Gym",          "subtask":"Leg Day", "date": "14/01/2014"]
        ]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:TaskCell = tableView.dequeueReusableCellWithIdentifier("myCell") as TaskCell
        
        let task = taskArray[indexPath.row]
        
        cell.taskLabel.text = task["task"]
        cell.descriptionLabel.text = task["subtask"]
        cell.dateLabel.text = task["date"]
        
        return cell
    }
    
    //UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println(indexPath.section, indexPath.row)
    }
}

