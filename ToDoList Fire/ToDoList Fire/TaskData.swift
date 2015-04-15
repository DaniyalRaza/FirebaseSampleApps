//
//  TaskData.swift
//  ToDoList Fire
//
//  Created by PanaCloud on 09/02/2015.
//  Copyright (c) 2015 PanaCloud. All rights reserved.
//

import UIKit

class TaskData: NSObject {
   
    var taskId:String
    var taskTitle:String
    var taskDescription:String
    var taskTime:NSDate
    
    
    init(taskId:String,taskTitle:String,taskDescription:String,taskTime:NSDate) {
        self.taskId=taskId
        self.taskTitle=taskTitle
        self.taskDescription=taskDescription
        self.taskTime=taskTime
    }
    
}
