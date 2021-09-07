//
//  CardCollectionViewCell.swift
//  RunningApp
//
//  Created by Centauro on 8/13/21.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {

   // @IBOutlet weak var challengeImageView: UIImageView!
    @IBOutlet var titleLbl: UILabel!
    
    @IBOutlet var challengeImageView: UIImageView!
    func setup(with challenge: Challenge) {
        print("llega a card")
        
        challengeImageView.image = challenge.image
        titleLbl.text = challenge.title
    }
}
