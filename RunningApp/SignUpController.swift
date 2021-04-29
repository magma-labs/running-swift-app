//
//  SignUpController.swift
//  RunningApp
//
//  Created by admin on 4/29/21.
//

import UIKit
import FirebaseAuth

class SignUpController: UIViewController {
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var confirmPasswordInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signUpBtn(_ sender: Any) {
        let email: String = emailInput.text!
        let password: String = passwordInput.text!
        let confirmPassword: String = confirmPasswordInput.text!
        
        if password == confirmPassword {
            Auth.auth().createUser(withEmail: email, password: password) {(authResult, error) in
                if (authResult?.user) != nil {
                    self.emailInput.text = ""
                    self.passwordInput.text = ""
                    self.confirmPasswordInput.text = ""
                    
                    let next = self.storyboard?.instantiateViewController(withIdentifier: "LoginController") as! LoginController
                    self.present(next, animated: true)
                } else {
                    print("Error to created")
                }
            }
        } else {
            print("No coinciden")
        }
    }
    
    @IBAction func redirectLogin(_ sender: Any) {
        let next = self.storyboard?.instantiateViewController(withIdentifier: "LoginController") as! LoginController
        self.present(next, animated: true)
    }
    
    @IBAction func forgotPasswordBtn(_ sender: Any) {
    }
}
