//
//  challengeList.swift
//  RunningApp
//
//  Created by Centauro on 8/20/21.
//

import SwiftUI

struct challengeType {
    let name: String
    let description: String
    let image: String
    let members: Int
    let date: String
}


let actualChallenges = [
    challengeType(
        name: "Los Angeles",
        description: "Cartago, San José, recorrido de 5, 10 o 20 kilometros, pueden asistir personas apartir de 15 años",
        image: "pista",
        members: 6, date: "5/09/2021"),
    challengeType(
        name: "Guanacaste Running",
        description: "Cartago, San José, recorrido de 5, 10 o 20 kilometros, pueden asistir personas apartir de 15 años",
        image: "pista",
        members: 4, date: "29/08/2021"
    )
]

let oldChallenges = [
    challengeType(
        name: "Escazu Running",
        description: "Cartago, San José, recorrido de 5, 10 o 20 kilometros, pueden asistir personas apartir de 15 años",
        image: "pista",
        members: 6,
        date: "06/03/2021"),
    challengeType(
        name: "Arenal Running",
        description: "La fortuna, Alajuela, recorrido de 5, 10 o 20 kilometros, pueden asistir personas apartir de 15 años",
        image: "pista",
        members: 10,
        date: "15/01/2021"),
    challengeType(
        name: "La Sabana Running",
        description: "San Jose recorrido de 5, 10 o 20 kilometros, pueden asistir personas apartir de 15 años",
        image: "pista",
        members: 10,
        date: "10/02/2021")
]



