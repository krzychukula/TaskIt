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
    
    var baseArray:[[TaskModel]] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let date1 = Date.from(year: 2014, month: 12, day: 24)
        
        let taskArray = [
            TaskModel(task: "Study French", subTask: "Verbs", date: date1, completed: false),
            TaskModel(task: "Eat Dinner",
                subTask: "Soup",
                date: Date.from(year: 2014, month: 12, day: 25),
                completed: false),
            TaskModel(task: "Gym",
                subTask: "Leg Day",
                date: Date.from(year: 2014, month: 12, day: 26),
                completed: false)
        ]
        
        var completedArray = [TaskModel(task: "Code", subTask: "Task Project", date: date1, completed: true)]
        
        baseArray = [taskArray, completedArray]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
//        func sortByDate(taskOne:TaskModel, taskTwo:TaskModel) -> Bool {
//            return taskOne.date.timeIntervalSince1970 < taskTwo.date.timeIntervalSince1970
//        }
//        
//        taskArray = taskArray.sorted(sortByDate)
        let taskArray = baseArray[0]
        
        baseArray[0] = taskArray.sorted{
            (taskOne:TaskModel, taskTwo:TaskModel) -> Bool in
            
            return taskOne.date.timeIntervalSince1970 < taskTwo.date.timeIntervalSince1970
        }
        
        tableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showTaskDetail" {
            let detailVC = segue.destinationViewController as TaskDetailViewController
            detailVC.mainVC = self
            let indexPath = self.tableView.indexPathForSelectedRow()
            let thisTask = baseArray[indexPath!.section][indexPath!.row]
            detailVC.detailTaskModel = thisTask
        }else if segue.identifier == "showTaskAdd" {
            var addTaskVC = segue.destinationViewController as AddTaskViewController
            addTaskVC.mainVC = self;
        }
        
    }
    
    @IBAction func addButtonTapped(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("showTaskAdd", sender: self)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return baseArray.count
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "To do" : "Completed"
    }

    //UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return baseArray[section].count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:TaskCell = tableView.dequeueReusableCellWithIdentifier("myCell") as TaskCell
        
        let task = baseArray[indexPath.section][indexPath.row]
        
        cell.taskLabel.text = task.task
        cell.descriptionLabel.text = task.subTask
        cell.dateLabel.text = Date.toString(date: task.date)
        
        return cell
    }
    
    //UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println(indexPath.section, indexPath.row)
        
        performSegueWithIdentifier("showTaskDetail", sender: self)
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let thisTask = baseArray[indexPath.section][indexPath.row]
        var newTask = TaskModel(task: thisTask.task, subTask: thisTask.subTask, date: thisTask.date, completed: true)
        
        baseArray[indexPath.section].removeAtIndex(indexPath.row)
        baseArray[1].append(newTask)
        
        tableView.reloadData()
    }
}

