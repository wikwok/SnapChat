//
//  SignInViewController.swift
//  SnapChat
//
//  Created by Salih Alborno on 12/06/2017.
//  Copyright © 2017 test. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class SignInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    @IBAction func turnupTapped(_ sender: Any) {

        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
            print("We Tried To Sign In")
            if error != nil {
                print("Hey!, We have an error:\(String(describing: error))")
                Auth.auth().createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (user, error) in
                    print("We Tried to Create a User")
                    if error != nil {
                        print("Hey we have an error:\(String(describing: error))")
                    } else {
                        print("Created User Successfully")
                        
                        Database.database().reference().child("users").child(user!.uid).child("email").setValue(user!.email)
                        
                        self.performSegue(withIdentifier: "signinSegue", sender: nil)
                    }
                })
            } else {
                print("Signed In Successfully")
                self.performSegue(withIdentifier: "signinSegue", sender: nil)
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

