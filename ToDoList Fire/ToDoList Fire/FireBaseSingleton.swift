//
//  FireBaseSingleton.swift
//  ToDoList Fire
//
//  Created by PanaCloud on 09/02/2015.
//  Copyright (c) 2015 PanaCloud. All rights reserved.
//

import UIKit

class FireBaseSingleton: NSObject {
   
        class var sharedData:FireBaseSingleton{
            struct Singleton{
                static let instance=FireBaseSingleton()
            }
            return Singleton.instance
        }
    
    
    var useruid:String!
    
    
    var appRoot=Firebase(url: "https://to-do-list-daniyal.firebaseio.com")
    
    var tasks:[TaskData]=[]
    
    func addTask(taskTitle:String,taskDescription:String,taskDate:NSDate){
        
        println("Add task called")
        
        println(taskDate)
        
        var tasksRef=appRoot.childByAppendingPath("tasks").childByAppendingPath(useruid)
        
//        
//        tasksRef.childByAppendingPath(<#pathString: String!#>)
        
        var taskDict:Dictionary=["taskTitle":"\(taskTitle)","taskDescription":"\(taskDescription)","taskDate":"\(taskDate)"]
        
        tasksRef.childByAutoId().setValue([
                "taskTitle":"\(taskTitle)",
                "taskDescription":"\(taskDescription)",
                "taskDate":"\(taskDate)"
            ])
        
    }
    
    
    func addUser(email:String,uid:String){
        var usersRef=appRoot.childByAppendingPath("users").childByAppendingPath("\(uid)")
        //var userDict:Dictionary=["email":"\(email)"]
        usersRef.setValue(["email":"\(email)"])
    }
    
    
    
    
    func childListener(completion:(()->Void)){
        println("child Added Called")
        var tasksRef=appRoot.childByAppendingPath("tasks").childByAppendingPath(useruid)
        

        
        // Retrieve new posts as they are added to Firebase
        tasksRef.observeEventType(.ChildAdded, withBlock: { snapshot in
            println(snapshot)
            
            println("------------------------\(snapshot)")
            
            println(snapshot.key)
            println(snapshot.value)

            
                var taskId:String=snapshot.key as String
            
               var taskTitle:String=snapshot.value.objectForKey("taskTitle") as String
                var taskDescription:String=snapshot.value.objectForKey("taskDescription") as String
                
                var dateFormatter=NSDateFormatter()
                dateFormatter.dateFormat="YYYY-MM-DD HH:mm:ss Z"
                var dateString:String=snapshot.value.objectForKey("taskDate") as String

                var taskDate = dateFormatter.dateFromString(dateString)
            
              var taskObject=TaskData(taskId:taskId,taskTitle: taskTitle, taskDescription: taskDescription, taskTime: taskDate!)
            
               self.tasks.insert(taskObject, atIndex: 0)
            
                
                
                
    
            completion()
            }, withCancelBlock: { error in
                println(error.description)
        })

            
            
        
        

    }
    
//    func fetchInitialTasks(completion:(()->Void)){
//        
//    
//    
//    // Get a reference to our posts
//    var tasksRef=appRoot.childByAppendingPath("tasks")
//    
//    // Attach a closure to read the data at our posts reference
//    tasksRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
//     
//        self.tasks=[]
//        
//        println("Hello bfiabfiabifa")
//        
//        
//    }

    
    
    
    
    func updateData(taskId:String,taskTitle:String,taskDescription:String,taskDate:NSDate){
        
        println("nfkabgibgyuabguyabguyabg")
        
        var tasksRef=appRoot.childByAppendingPath("tasks").childByAppendingPath(useruid)
        
        var singleTaskRef = tasksRef.childByAppendingPath(taskId)
        
        
        singleTaskRef.updateChildValues([
                "taskTitle":"\(taskTitle)",
                "taskDescription":"\(taskDescription)",
                "taskDate":"\(taskDate)"
            ])
        
        fetchUpdatedTasks({Void in
            
        })
    }
    
    
    
    
    
    func deleteData(taskId:String){
        var tasksRef=appRoot.childByAppendingPath("tasks").childByAppendingPath(useruid)
        var singleTaskRef = tasksRef.childByAppendingPath(taskId)
        singleTaskRef.removeValue()
    }
    
    
    
    func attachDeleteListener(){
    
        
        
        println("afsagaghashahafhafhahafhafhafha\(self.useruid)")
        
        
       
        
        // Get a reference to our posts
        var tasksRef=appRoot.childByAppendingPath("tasks").childByAppendingPath("simplelogin:4")
        
        // Get the data on a post that has been removed
        tasksRef.observeEventType(.ChildRemoved, withBlock: { snapshot in
            
            println(self.useruid)
            
            
          
            
            var deletedTask=snapshot.key as String
            for(var i=0;i<self.tasks.count;i++){
                if(deletedTask==self.tasks[i].taskId){
                    self.tasks.removeAtIndex(i)
                    globalTableView.reloadData()
                }
            }
        })
        
    }
    
    func fetchUpdatedTasks(completion:(()->Void)){
        // Get a reference to our posts
        println("Hello")
        var tasksRef=appRoot.childByAppendingPath("tasks").childByAppendingPath(useruid)
        // Get the data on a post that has changed
        tasksRef.observeEventType(.ChildChanged, withBlock: { snapshot in
            
            
            
            var changedTaskId:String=snapshot.key as String
            
            for(var i=0;i<self.tasks.count;i++){
                
                println("\(changedTaskId)-----------\(self.tasks[i].taskId)")
                
                if(changedTaskId==self.tasks[i].taskId){
                    
                    self.tasks.removeAtIndex(i)
                    
                    var taskId:String=snapshot.key as String
                    
                    var taskTitle:String=snapshot.value.objectForKey("taskTitle") as String
                    var taskDescription:String=snapshot.value.objectForKey("taskDescription") as String
                    
                    var dateFormatter=NSDateFormatter()
                    dateFormatter.dateFormat="YYYY-MM-DD HH:mm:ss Z"
                    var dateString:String=snapshot.value.objectForKey("taskDate") as String
                    
                    var taskDate = dateFormatter.dateFromString(dateString)
                    
                    var taskObject=TaskData(taskId:taskId,taskTitle: taskTitle, taskDescription: taskDescription, taskTime: taskDate!)
                    
                    self.tasks.insert(taskObject, atIndex: i)
                    
                    globalTableView.reloadData()

                }
            }
            
         completion()
        })
    }
    
    
    
    func signup(email:String,password:String,completion:(()->Void)){
       
        appRoot.createUser("\(email)", password: "\(password)",
            withValueCompletionBlock: { error, result in
                
                if error != nil {
                    // There was an error creating the account
                    println(error)
                } else {
                    //self.useruid = result["uid"] as? String
                    var uid=result["uid"] as? String
                    println("Successfully created user account with uid: \(self.useruid)")
                    
                    self.addUser(email, uid: uid!)
                    
                    completion()
                }
        })
    }
    
    
    func signin(email:String,password:String,completion:(()->Void)){
        
        appRoot.authUser("\(email)", password: "\(password)",
            withCompletionBlock: { error, authData in
                
                if error != nil {
                    // There was an error logging in to this account
                } else {
                    // We are now logged in
                    self.useruid=authData.uid
                    println(self.useruid)
                    completion()
                }
        })
    }
    
    
}
