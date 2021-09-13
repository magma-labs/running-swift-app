//
//  ResumeController.swift
//  RunningApp
//
//  Created by admin on 5/12/21.
//

import UIKit

class ResumeController: UIViewController, UICollectionViewDelegate {
    
    var showData = true
    var showFinalized = false;
        
 
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var tableView: UITableView!
   
    
    @IBOutlet weak var progressBtn: UIButton!
    @IBOutlet weak var endedBtn: UIButton!
    
    @IBAction func progress(_ sender: UIButton) {
        progressBtn.setTitleColor(UIColor.red, for: .normal)
        endedBtn.setTitleColor(UIColor.black, for: .normal)
        
        showData = true;
        showFinalized = false;
        tableView.reloadData();
        
    }
    
    
    @IBAction func finalized(_ sender: UIButton) {
        progressBtn.setTitleColor(UIColor.black, for: .normal)
        endedBtn.setTitleColor(UIColor.red, for: .normal)
        
        showData = false;
        showFinalized = true;
        tableView.reloadData();
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.reloadData()
        tableView.reloadData()

    }
}






extension ResumeController:
    UICollectionViewDataSource{

    
    func collectionView(_ collectionView:
        UICollectionView, numberOfItemsInSection
            section:Int) -> Int {
        print("collection 1 ", challenges.count)
        return challenges.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCollectionViewCell", for: indexPath)  as! CardCollectionViewCell
        
        cell.setup(with: challenges[indexPath.row])
        
        return cell
    }
    
    
    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        print("collection 2")
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCollectionViewCell", for: indexPath) as! CardCollectionViewCell
//        cell.setup(with: challenges[indexPath.row])
//
//        return cell
//    }
}


//extension ResumeController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("llega a tableview 1")
//        navigationController?.pushViewController(InviteFriendViewController, animated: true)
//    }
//}

extension ResumeController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var items = 0
        
        
        if(showData) {
            items = showData ? actualChallenges.count : 0
        } else {
            items = showFinalized ? oldChallenges.count : 0
        }
        

        return items
    }
    
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("llega a cell table view 3");
        
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChallengesTableViewCell", for: indexPath) as! ChallengesTableViewCell
        if(showData){
        cell.setupData(with: actualChallenges[indexPath.row])
        } else {
            cell.setupData(with: oldChallenges[indexPath.row])

        }
        return cell
        
    }
    
    
}
