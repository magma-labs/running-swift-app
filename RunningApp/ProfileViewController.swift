//
//  ProfileViewController.swift
//  RunningApp
//
//  Created by Alberto Aldana on 07/05/21.
//

import UIKit

class User {
   let name : String
   let lastName : String
   let username: String
   let email: String

    init(name: String, lastName: String, username: String, email: String) {
       self.name = name
       self.lastName = lastName
       self.username = username
       self.email = email
   }
}

class ProfileViewController: UIViewController {

    @IBOutlet weak var notifView: UIView!
    @IBOutlet weak var configView: UIView!
    @IBOutlet weak var logoutView: UIView!
    
    override func viewDidLoad() {
        
        
        //design
        
        notifView.layer.cornerRadius = 10;
        notifView.layer.masksToBounds = true;
        
        configView.layer.cornerRadius = 10;
        configView.layer.masksToBounds = true;
        
        logoutView.layer.cornerRadius = 10;
        logoutView.layer.masksToBounds = true;
        
        super.viewDidLoad()
        print("Profile loaded!")
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
