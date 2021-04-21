//
//  RetosViewController.swift
//  RunningApp
//
//  Created by Alberto Aldana on 14/04/21.
//

import UIKit
import SwiftUI

class Reto {
   let userA : String
   let userB : String
   let km : String

    init(userA : String, userB: String, km: String) {
       self.userA = userA
       self.userB = userB
       self.km = km
   }
}


class RetosTVC: UITableViewCell {
    
    @IBOutlet weak var retosFriend: UILabel!
    @IBOutlet weak var km: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

class RetosViewController: UIViewController, UITableViewDataSource {
    
    @State private var date = Date()
    @State public var segmented = 0
    
    
    @IBOutlet weak var retosTableView: UITableView!
    
    var rets:[Reto] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = retosTableView.dequeueReusableCell(withIdentifier: "cell") as! RetosTVC
        let reto = rets[indexPath.row]
    
        
        cell.retosFriend.text = reto.userB
        cell.km.text = reto.km
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("Retos view controller loaded")
    
        
        let reto1 = Reto(userA: "Alberto", userB: "Ramon", km: "20")
        let reto2 = Reto(userA: "Pato", userB: "Pepe", km: "32")
        let reto3 = Reto(userA: "Raul", userB: "Marcos", km: "10")
        let reto4 = Reto(userA: "Pancho", userB: "Jose", km: "12")
        
        rets.append(reto1)
        rets.append(reto2)
        rets.append(reto3)
        rets.append(reto4)
        
        retosTableView.dataSource = self
    }

    
    @IBAction func retoType(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            print("Retos en curso")
        case 1:
            print("Hostorial de los retos")
        default:
            print("nil")
        }
    }
    
}
