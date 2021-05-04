//
//  RetosViewController.swift
//  RunningApp
//
//  Created by Alberto Aldana on 14/04/21.
//

import UIKit
import FirebaseFirestore

class Logro {
   let title : String
   let icon : String
   let description : String
   let date: String


   init(title: String, icon: String, description: String, date: String) {
           self.title = title
           self.icon = icon
           self.description = description
           self.date = date
       }
}

class LogrosTVC: UITableViewCell {
    
    @IBOutlet weak var logroDescription: UILabel!
    @IBOutlet weak var logroDate: UILabel!
    @IBOutlet weak var logroTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

class LogrosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var logrosTableView: UITableView!
    var path = IndexPath()
    
    var logros:[Logro] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return logros.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = logrosTableView.dequeueReusableCell(withIdentifier: "logrosCell") as! LogrosTVC
        let logro = logros[indexPath.row]
    
        cell.logroDescription.text = logro.description
//        cell.km.text = "\(reto.km)"
        
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let db = Firestore.firestore();
        
        db.collection("achievements").addSnapshotListener { querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    print("Error fetching documents: \(error!)")
                    return
                }
            let _: [()] = documents.map {
                    print("logors ->", $0)
                    let logr = Logro(
                        title: $0["title"] as! String,
                        icon: "",
                        description: $0["description"] as! String,
                        date: $0["date"] as! String
                    )
                
                    self.logros.append(logr)
                }
           
            self.logrosTableView.reloadData();
            
            return
        }
        
        logrosTableView.dataSource = self
        logrosTableView.delegate = self
    }
    

}
