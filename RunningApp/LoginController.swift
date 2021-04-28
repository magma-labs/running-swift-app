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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func SignIn(_ sender: Any) {
        let email = "fernando@magma.io"
        let password = "testing123"
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
          guard let strongSelf = self else { return }
            
            if let error = error as? NSError {
              switch AuthErrorCode(rawValue: error.code) {
                  case .invalidEmail:
                    self?.lblErrors?.text = "Invalid Email"
                  default:
                    self?.lblErrors?.text = "Contraseña incorrecta"
              }
            } else {
              let newUserInfo = Auth.auth().currentUser
              let email = newUserInfo?.email
            
              let next = self?.storyboard?.instantiateViewController(withIdentifier: "MainController") as! UITabBarController
              self?.present(next, animated: true)
            }
        }
    }
}
