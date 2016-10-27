//
//  ViewController.swift
//  ParseChatter
//
//  Created by James Zhou on 10/26/16.
//  Copyright © 2016 James Zhou. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLogin(_ sender: Any) {
        
        let password = passwordTextField.text
        let username = emailTextField.text
        
        PFUser.logInWithUsername(inBackground: username!, password: password!, block: { (user: PFUser?, error: Error?) in
            
            if (user != nil) {
                
                self.performSegue(withIdentifier: "gotochat", sender: self)
                
            } else {
                let alertController =  UIAlertController(title: "Log in failed", message: "Wrong username/password", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: { (action: UIAlertAction) in
                    //
                })
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true, completion: nil)
            }
            
        }
    )
        
        
    }
    
    @IBAction func onSignup(_ sender: Any) {
        
        let user = PFUser()
        user.password = passwordTextField.text
        user.username = emailTextField.text
        
        user.signUpInBackground { (isSuccess: Bool, error: Error?) in
            
            print("sign up is successful: \(isSuccess)")
            
            if (!isSuccess) {
                let alertController =  UIAlertController(title: "Sign up failed", message: "Might already been registered", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: { (action: UIAlertAction) in
                    //
                })
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true, completion: nil)
            } else {
                self.performSegue(withIdentifier: "gotochat", sender: self)
            }
            
        }
        
        
    }
    

}

