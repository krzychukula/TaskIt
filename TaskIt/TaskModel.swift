//
//  TaskModel.swift
//  TaskIt
//
//  Created by Krzysztof Kula on 26/12/14.
//  Copyright (c) 2014 Krzysztof Kula. All rights reserved.
//

import Foundation
import CoreData

@objc(TaskModel)
class TaskModel: NSManagedObject {

    @NSManaged var completed: NSNumber
    @NSManaged var date: NSDate
    @NSManaged var subtask: String
    @NSManaged var task: String

}
