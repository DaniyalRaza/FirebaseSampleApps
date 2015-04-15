//
//  SignupViewController.swift
//  ToDoList Fire
//
//  Created by PanaCloud on 13/04/2015.
//  Copyright (c) 2015 PanaCloud. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func signup(sender: AnyObject) {
        
        FireBaseSingleton.sharedData.signup(emailTextField.text, password: passwordTextField.text){Void in
            
            var vc=self.storyboard?.instantiateViewControllerWithIdentifier("NavigationController") as UINavigationController
            self.presentViewController(vc, animated: true, completion: nil)
        }
        
    }

}
