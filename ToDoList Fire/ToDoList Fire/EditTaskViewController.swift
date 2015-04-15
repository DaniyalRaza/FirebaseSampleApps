//
//  EditTaskViewController.swift
//  ToDoList Fire
//
//  Created by PanaCloud on 09/02/2015.
//  Copyright (c) 2015 PanaCloud. All rights reserved.
//

import UIKit

class EditTaskViewController: UIViewController {
    
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    
    
    var currentTask:Int!

    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        titleTextField.text="\(FireBaseSingleton.sharedData.tasks[selectedTask].taskTitle)"
        descriptionTextView.text="\(FireBaseSingleton.sharedData.tasks[selectedTask].taskDescription)"
        datePicker.date=FireBaseSingleton.sharedData.tasks[selectedTask].taskTime
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func editTask(sender: AnyObject) {
        
        println()
        
        FireBaseSingleton.sharedData.updateData(FireBaseSingleton.sharedData.tasks[selectedTask].taskId,taskTitle:titleTextField.text,taskDescription: descriptionTextView.text,taskDate: datePicker.date)
            
        
        
        
//                FireBaseSingleton.sharedData.fetchUpdatedTasks({Void in
//                    
//                })
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
