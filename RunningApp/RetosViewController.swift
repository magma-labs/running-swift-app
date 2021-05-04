//
//  RetosViewController.swift
//  RunningApp
//
//  Created by Alberto Aldana on 14/04/21.
//

import UIKit
import SwiftUI
import FirebaseFirestore

class Reto {
   let userB : String
   let km : Int
   let winner: Bool
   let myKm: Int
   let daysLeft: Int
   let opponentKm: Int

    init(userB: String, km: Int, winner: Bool, myKm: Int, daysLeft: Int, opponentKm: Int) {
       self.userB = userB
       self.km = km
       self.winner = winner
       self.myKm = myKm
       self.daysLeft = daysLeft
       self.opponentKm = opponentKm
   }
}


class RetosTVC: UITableViewCell {
    
    @IBOutlet weak var retosFriend: UILabel!
    @IBOutlet weak var km: UILabel!
    @IBOutlet weak var result: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

class RetosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @State private var date = Date()
    @State public var segmented = 0
    
    
    @IBOutlet weak var retosTableView: UITableView!
    var path = IndexPath()
    
    var rets:[Reto] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = retosTableView.dequeueReusableCell(withIdentifier: "cell") as! RetosTVC
        let reto = rets[indexPath.row]
    
        cell.retosFriend.text = reto.userB
        cell.km.text = "\(reto.km)"
        
        if(reto.winner){
            cell.result.text = "Ganando"
            cell.result.textColor = UIColor.green
        } else {
            cell.result.text = "Perdiendo"
            cell.result.textColor = UIColor.red
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView,willSelectRowAt indexPath: IndexPath) -> IndexPath? {
            path = indexPath
            return indexPath
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        retosTableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "retosDetailSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let retosVC = segue.destination as? RetosDetailVC else { return }
        retosVC.opponentText = rets[path.row].userB
        retosVC.daysLeftText = rets[path.row].daysLeft
        retosVC.kmText = rets[path.row].km
        retosVC.myKmText = rets[path.row].myKm
        retosVC.opponentKmText = rets[path.row].opponentKm
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let db = Firestore.firestore();
        
        db.collection("challenges").addSnapshotListener { querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    print("Error fetching documents: \(error!)")
                    return
                }
            let _: [()] = documents.map {
                    let ret = Reto(
                        userB: $0["opponent"] as! String,
                        km: $0["km"] as! Int,
                        winner: false,
                        myKm: $0["myKm"] as! Int,
                        daysLeft: $0["daysLeft"] as! Int,
                        opponentKm: $0["opponentKm"] as! Int
                    )
                
                    self.rets.append(ret)
                }

            self.retosTableView.reloadData()
            return
        }
        
        retosTableView.dataSource = self
        retosTableView.delegate = self

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
