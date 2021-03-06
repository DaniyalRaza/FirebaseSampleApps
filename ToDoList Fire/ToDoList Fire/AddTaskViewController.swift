//
//  AddTaskViewController.swift
//  ToDoList Fire
//
//  Created by PanaCloud on 09/02/2015.
//  Copyright (c) 2015 PanaCloud. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {
    
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    
    
    
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    @IBAction func addTask(sender: AnyObject) {
        
        println("Hello")
        
        
        
        if(titleTextField.text.isEmpty){
            UIAlertView(title: "Title is Empty", message: "Please Enter Title", delegate: self, cancelButtonTitle: "Cancel").show()
        }
        else if(descriptionTextView.text.isEmpty){
            UIAlertView(title: "Description is Empty", message: "Please Enter Description", delegate: self, cancelButtonTitle: "Cancel").show()
        }
        else{
            FireBaseSingleton.sharedData.addTask(titleTextField.text, taskDescription: descriptionTextView.text, taskDate: datePicker.date)
            
            
            self.navigationController?.popViewControllerAnimated(true)

        }
        
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
