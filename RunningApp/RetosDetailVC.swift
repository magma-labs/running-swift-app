//
//  RetosDetailVC.swift
//  RunningApp
//
//  Created by Alberto Aldana on 21/04/21.
//

import UIKit

class RetosDetailVC: UIViewController {

    @IBOutlet weak var km: UILabel!
    
    var reto: Reto?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //km.text = "\((reto?.km)!)"
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
