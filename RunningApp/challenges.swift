//
//  challenges.swift
//  RunningApp
//
//  Created by Centauro on 8/16/21.
//

import UIKit

struct Challenge {
    let title: String
    let image: UIImage
}

let pista = UIImage(named: "montaña")

let challenges: [Challenge] = [
    Challenge(title: "The Northern Way 2", image: UIImage(named: "pista.jpeg")!),
    Challenge(title: "The Northern Way", image: UIImage(named: "pista.jpeg")!),
    Challenge(title: "Italy Divide",  image: UIImage(named: "pista.jpeg")! ),
    Challenge(title: "Carso Trail",  image: UIImage(named: "pista.jpeg")! )
]
