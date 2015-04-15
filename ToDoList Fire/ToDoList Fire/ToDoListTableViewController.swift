//
//  ToDoListTableViewController.swift
//  ToDoList Fire
//
//  Created by PanaCloud on 09/02/2015.
//  Copyright (c) 2015 PanaCloud. All rights reserved.
//

import UIKit

var selectedTask:Int!

var globalTableView:UITableView!

class ToDoListTableViewController: UITableViewController {
    
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.navigationItem.hidesBackButton=true
        
        globalTableView=self.tableView
        
        // Uncomment the following line to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = false
        
         activityIndicator.startAnimating()

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
       
        
        
                        FireBaseSingleton.sharedData.childListener({Void in
                            println(FireBaseSingleton.sharedData.tasks.count)
                            self.tableView.reloadData()
                            self.activityIndicator.stopAnimating()
                        })
        
        
        
                        FireBaseSingleton.sharedData.fetchUpdatedTasks({Void in
        
                        })

        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return FireBaseSingleton.sharedData.tasks.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell

        cell.textLabel?.text=FireBaseSingleton.sharedData.tasks[indexPath.row].taskTitle
        cell.detailTextLabel?.text=FireBaseSingleton.sharedData.tasks[indexPath.row].taskDescription

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }


    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if editingStyle == .Delete {
            // Delete the row from the data source
            
               FireBaseSingleton.sharedData.deleteData(FireBaseSingleton.sharedData.tasks[indexPath.row].taskId)
            
            //FireBaseSingleton.sharedData.tasks.removeAtIndex(indexPath.row)
            
         
            
           // tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        //} else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        //}
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       
        
        selectedTask=indexPath.row
        println(selectedTask)
        
       // performSegueWithIdentifier("editTaskSegue", sender: self)
        //println(selectedTask.taskTitle)
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        
        if(segue.identifier=="editTaskSegue"){
            
            println("segue performed")
            var destVC=segue.destinationViewController as EditTaskViewController
           // println(selectedTask.taskTitle)
           // var abc=selectedTask.taskTitle
            
            destVC.currentTask=selectedTask
        }
        
        
    }


}
