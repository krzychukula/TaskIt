//
//  ViewController.swift
//  TaskIt
//
//  Created by Krzysztof Kula on 21/12/14.
//  Copyright (c) 2014 Krzysztof Kula. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
    var fetchedResultsController:NSFetchedResultsController = NSFetchedResultsController()
    
    var baseArray:[[TaskModel]] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        fetchedResultsController = getFetchedResultsController()
        
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
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return baseArray.count
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "To do" : "Completed"
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println(indexPath.section, indexPath.row)
        
        performSegueWithIdentifier("showTaskDetail", sender: self)
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let thisTask = baseArray[indexPath.section][indexPath.row]
        
        if indexPath.section == 0 {
            var newTask = TaskModel(task: thisTask.task, subTask: thisTask.subTask, date: thisTask.date, completed: true)
            baseArray[1].append(newTask)
        }else {
            var newTask = TaskModel(task: thisTask.task, subTask: thisTask.subTask, date: thisTask.date, completed: false)
            
            baseArray[0].append(newTask)
        }
        baseArray[indexPath.section].removeAtIndex(indexPath.row)
        tableView.reloadData()
    }
    
    //Helper CoreData
    
    func taskFetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "TaskModel")
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        return fetchRequest
    }
    
    func getFetchedResultsController() -> NSFetchedResultsController {
        var fetchedResultsController = NSFetchedResultsController(fetchRequest: taskFetchRequest(), managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        return fetchedResultsController
    }
}

