//
//  ConfigViewController.swift
//  RunningApp
//
//  Created by Alberto Aldana on 10/05/21.
//

import UIKit

class ConfigViewController: UIViewController {

    @IBOutlet weak var saveChanges: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        
        saveChanges.layer.cornerRadius = 10;
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
