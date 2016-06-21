//
//  WarViewController.swift
//  WarGame
//
//  Created by Amy Joscelyn on 6/21/16.
//  Copyright © 2016 Amy Joscelyn. All rights reserved.
//

import Foundation
import UIKit

let card_back = "🐾"

class WarViewController: UIViewController
{
    @IBOutlet weak var winnerLabel: UILabel!
    @IBOutlet weak var houseDeckLabel: UILabel!
    @IBOutlet weak var houseCardInPlayLabel: UILabel!
    @IBOutlet weak var playerCardInPlayLabel: UILabel!
    @IBOutlet weak var playerDeckLabel: UILabel!
    @IBOutlet weak var playerCard1Label: UILabel!
    @IBOutlet weak var playerCard2Label: UILabel!
    @IBOutlet weak var playerCard3Label: UILabel!
    

    let dealer: Dealer = Dealer.init()
}
