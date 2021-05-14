//
//  RetosDetailVC.swift
//  RunningApp
//
//  Created by Alberto Aldana on 21/04/21.
//

import UIKit

class RetosDetailVC: UIViewController {

    @IBOutlet weak var km: UILabel!
    @IBOutlet weak var opponent: UILabel!
    @IBOutlet weak var daysLeft: UILabel!
    @IBOutlet weak var myProgress: UIProgressView!
    @IBOutlet weak var opponentProgress: UIProgressView!
    @IBOutlet weak var myProgressLabel: UILabel!
    @IBOutlet weak var opponentProgressLabel: UILabel!
    @IBOutlet weak var runButton: UIButton!
    
    var opponentText: String? = ""
    var kmText: Int? = 0
    var daysLeftText: Int? = 0
    var opponentKmText: Int? = 0
    var myKmText: Int? = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        runButton.layer.cornerRadius = 10;
        
        self.opponent.text = opponentText
        self.daysLeft.text = "Quedan \(daysLeftText ?? 0) dias"
        self.km.text = "Meta: \(kmText ?? 0) km"
        self.myProgressLabel.text = "\(myKmText ?? 0) de \(kmText ?? 0) km"
        self.opponentProgressLabel.text = "\(opponentKmText ?? 0) de \(kmText ?? 0) km"
        self.myProgress.setProgress(Float(myKmText!) / Float(kmText!), animated: true)
        self.opponentProgress.setProgress(Float(opponentKmText!) / Float(kmText!), animated: true)
        
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
