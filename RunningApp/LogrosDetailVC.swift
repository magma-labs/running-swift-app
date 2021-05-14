//
//  LogrosDetailVC.swift
//  RunningApp
//
//  Created by Alberto Aldana on 12/05/21.
//

import UIKit

class LogrosDetailVC: UIViewController {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var descriptionText: String? = ""
    var titleText: String? = ""
    var dateText: String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.descriptionLabel.text = descriptionText;
        self.titleLabel.text = titleText;
        self.dateLabel.text = dateText;
        
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
