//
//  TaskDetailViewController.swift
//  TaskIt
//
//  Created by Krzysztof Kula on 23/12/14.
//  Copyright (c) 2014 Krzysztof Kula. All rights reserved.
//

import UIKit

class TaskDetailViewController: UIViewController {
    
    var detailTaskModel:TaskModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        println(self.detailTaskModel)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}