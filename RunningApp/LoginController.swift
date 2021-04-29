//
//  LoginController.swift
//  RunningApp
//
//  Created by admin on 4/27/21.
//

import UIKit
import FirebaseAuth

class LoginController: UIViewController {
    @IBOutlet weak var lblErrors: UILabel!
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func SignIn(_ sender: Any) {
        let email = emailInput.text!
        let password = passwordInput.text!
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard self != nil else { return }
            
            if let error = error as NSError? {
              switch AuthErrorCode(rawValue: error.code) {
                  case .invalidEmail:
                    self?.lblErrors?.text = "Invalid Email"
                  default:
                    self?.lblErrors?.text = "Contraseña incorrecta"
              }
            } else {
              // This variables are getting by auth method
              let newUserInfo = Auth.auth().currentUser
              let email = newUserInfo?.email
                
              let next = self?.storyboard?.instantiateViewController(withIdentifier: "MainController") as! UITabBarController
              self?.present(next, animated: true)
            }
        }
    }
}
