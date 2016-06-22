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
    
    @IBOutlet weak var playContinueButton: UIButton!
    
    let dealer: Dealer = Dealer.init()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.winnerLabel.hidden = true
        self.houseDeckLabel.hidden = true
        self.playerDeckLabel.hidden = true
        self.houseCardInPlayLabel.hidden = true
        self.playerCardInPlayLabel.hidden = true
        self.playerCard1Label.hidden = true
        self.playerCard2Label.hidden = true
        self.playerCard3Label.hidden = true
    }
    
    @IBAction func playContinueButtonTapped(sender: UIButton)
    {
        //this is what should kick off the game, if it says "Let's play!"
        //if it says "Continue", it should just clear the board of cards in play so that the next card can be played
        if let title = sender.titleLabel
        {
            if title.text == "Let's Play!"
            {
                self.dealer.deal()
                
                self.houseDeckLabel.text = card_back
                self.playerDeckLabel.text = card_back
                
                self.houseDeckLabel.hidden = false
                self.playerDeckLabel.hidden = false
                
                //                self.playContinueButton.titleLabel?.text = "Continue"
                //this merely flashes the change, but then goes back to "Let's Play!"
            }
        }
    }
}
