//
//  ChallengesTableViewCell.swift
//  RunningApp
//
//  Created by Centauro on 8/25/21.
//

import UIKit

class ChallengesTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var durationLbl: UILabel!
    
    var duration = ""
    let dateFormatter = DateFormatter()
    let today = Date();

    func setupData(with challenge: challengeType) {
        duration = challenge.date;
        dateFormatter.dateFormat = "dd/MM/yy"
        let challengeDate = dateFormatter.date(from: duration)
        let delta = Calendar.current.dateComponents([.day], from: today, to: challengeDate!).day ?? 0

        titleLbl.text = challenge.name
        let day = delta > 1 ? " dias" : " dia"
        durationLbl.text = String(delta > 0 ? delta : 0) + day
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
