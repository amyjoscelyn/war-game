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
        
        self.tapGestures()
    }
    
    func tapGestures()
    {
        let deckTapGesture = UITapGestureRecognizer(target: self, action: #selector(WarViewController.deckTapped))
        self.playerDeckLabel.addGestureRecognizer(deckTapGesture)
        
        let card1TapGesture = UITapGestureRecognizer(target: self, action: #selector(WarViewController.card1Tapped))
        self.playerCard1Label.addGestureRecognizer(card1TapGesture)
        
        let card2TapGesture = UITapGestureRecognizer(target: self, action: #selector(WarViewController.card2Tapped))
        self.playerCard2Label.addGestureRecognizer(card2TapGesture)
        
        let card3TapGesture = UITapGestureRecognizer(target: self, action: #selector(WarViewController.card3Tapped))
        self.playerCard3Label.addGestureRecognizer(card3TapGesture)
    }
    
    @IBAction func playContinueButtonTapped(sender: UIButton)
    {
        //this is what should kick off the game, if it says "Let's play!"
        //if it says "Continue", it should just clear the board of cards in play so that the next card can be played
        if let title = sender.titleLabel
        {
            if title.text == "Let's Play!"
            {
                self.newGame()
            }
            else if title.text == "Continue"
            {
                
                //two cards are playing each other
                //this is where we need to award the winner
                //cards in play go to winner
                //or we go to a war
                //then we clear the card labels
                //I would kind of love to just make this a generic tap gesture on the view, so tap anywhere to continue
                //start fresh so we can go again
            }
        }
    }
    
    func newGame()
    {
        self.dealer.deal()
        
        self.houseDeckLabel.text = card_back
        self.playerDeckLabel.text = card_back
        
        self.houseDeckLabel.hidden = false
        self.playerDeckLabel.hidden = false
    }
    
    func deckTapped()
    {
        self.newRound()
    }
    
    func newRound()
    {
        self.dealer.round()
        
        if self.dealer.player.cardsInHand.count == 3
        {
            self.playerCard1Label.text = self.dealer.player.cardsInHand[0].cardLabel
            self.playerCard2Label.text = self.dealer.player.cardsInHand[1].cardLabel
            self.playerCard3Label.text = self.dealer.player.cardsInHand[2].cardLabel
            
            self.playerCard1Label.hidden = false
            self.playerCard2Label.hidden = false
            self.playerCard3Label.hidden = false
            self.playContinueButton.titleLabel?.hidden = true
        }
    }
    
    func card1Tapped()
    {
        if let card1Label = self.playerCard1Label.text
        {
            self.setCardToPlay(card1Label)
        }
    }
    
    func card2Tapped()
    {
        if let card2Label = self.playerCard2Label.text
        {
            self.setCardToPlay(card2Label)
        }
    }
    
    func card3Tapped()
    {
        //would I be able to get all three of these methods combined to one?
        
        if let card3Label = self.playerCard3Label.text
        {
            self.setCardToPlay(card3Label)
        }
    }
    
    func setCardToPlay(label: String)
    {
        for i in 0..<self.dealer.player.cardsInHand.count
        {
            let card = self.dealer.player.cardsInHand[i]
            
            if card.cardLabel == label
            {
                self.playerCard2Label.text = ""
                self.playerCard2Label.hidden = true
                
                self.turn(self.dealer.player.cardsInHand.removeAtIndex(i))
                
                break
            }
        }
    }
    
    func turn(card: Card)
    {
        self.dealer.player.cardInPlay = card
        self.playerCardInPlayLabel.text = card.cardLabel
        self.playerCardInPlayLabel.hidden = false
        
        self.dealer.cardsInPlay.append(card)
        
        self.dealer.turn()
        
        self.houseCardInPlayLabel.text = self.dealer.house.cardInPlay?.cardLabel
        self.houseCardInPlayLabel.hidden = false
        
        self.playerCard1Label.userInteractionEnabled = false
        self.playerCard2Label.userInteractionEnabled = false
        self.playerCard3Label.userInteractionEnabled = false
        
        self.playContinueButton.titleLabel?.text = "Continue"
        self.playContinueButton.titleLabel?.hidden = false
        
        let message = self.dealer.award()
        self.winnerLabel.text = message
        self.winnerLabel.hidden = false
        
        if self.dealer.house.cardsInHand.count == 0 && self.dealer.player.cardsInHand.count != 0
        {
            self.dealer.round()
            //You know, it would be kind of cool to see the computer's cardsInHand as well, and to see which it chooses each turn
            //maybe it can go right at the top, and the winner bar can be translucent over it when it pops up, since those cards aren't interactive anyway
        }
    }
}
