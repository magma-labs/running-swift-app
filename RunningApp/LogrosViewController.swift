//
//  LogrosViewController.swift
//  RunningApp
//
//  Created by Alberto Aldana on 12/05/21.
//

import UIKit
import FirebaseFirestore

class Logro {
   let title: String
   let icon: Int
   let description: String
   let date: String

   init(title: String, icon: Int, description: String, date: String) {
           self.title = title
           self.icon = icon
           self.description = description
           self.date = date
       }
}

class LogrosTVC: UITableViewCell {

    @IBOutlet weak var logroTitle: UILabel!
    @IBOutlet weak var logroDescription: UILabel!
    @IBOutlet weak var logroDate: UILabel!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let logro1 = Logro(title: "Completar primeros 5 KM", icon: 5, description: "Has completado tus primeros 5 KM", date: "17/02/2021")
//
//        let logro2 = Logro(title: "3 rivales", icon: 5, description: "Has vencido a 3 rivales en una sola semana", date: "16/02/2021")
//
//        logros.append(logro1)
//        logros.append(logro2)
        
                let db = Firestore.firestore();
        
                db.collection("achievements").addSnapshotListener { querySnapshot, error in
                        guard let documents = querySnapshot?.documents else {
                            print("Error fetching documents: \(error!)")
                            return
                        }
                    let _: [()] = documents.map {
        
                            let logr = Logro(
                                title: $0["title"] as! String,
                                icon: $0["icon"] as! Int,
                                description: $0["description"] as! String,
                                date: $0["date"] as! String
                            )
        
                            self.logros.append(logr)
                        }
        
                    self.logrosTableView.reloadData();
        
                    return
                }
        
        // Do any additional setup after loading the view.
        
        logrosTableView.dataSource = self
        logrosTableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return logros.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = logrosTableView.dequeueReusableCell(withIdentifier: "logrosCell" ) as! LogrosTVC
        
        let logro = logros[indexPath.row]
        //
        cell.logroDescription.text = logro.description
        cell.logroTitle.text = logro.title
        cell.logroDate.text = logro.date
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        logrosTableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "logrosDetailSegue", sender: self)
    }
    
    func tableView(_ tableView: UITableView,willSelectRowAt indexPath: IndexPath) -> IndexPath? {
            path = indexPath
            return indexPath
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let logrosVC = segue.destination as? LogrosDetailVC else { return }
        
        logrosVC.titleText = logros[path.row].title
        logrosVC.descriptionText = logros[path.row].description
        logrosVC.dateText = logros[path.row].date
        
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
