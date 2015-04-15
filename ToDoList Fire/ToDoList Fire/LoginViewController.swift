//
//  LoginViewController.swift
//  ToDoList Fire
//
//  Created by PanaCloud on 13/04/2015.
//  Copyright (c) 2015 PanaCloud. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

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
    @IBAction func signin(sender: AnyObject) {
        
        FireBaseSingleton.sharedData.signin(emailTextField.text, password: passwordTextField.text, completion: {Void in
            var vc=self.storyboard?.instantiateViewControllerWithIdentifier("TodoController") as ToDoListTableViewController
            println(self.navigationController)
            self.navigationController?.pushViewController(vc, animated: true)
        })
        
    }

}
