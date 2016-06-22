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
    
    @IBOutlet weak var houseWarCard1Label: UILabel!
    @IBOutlet weak var houseWarCard2Label: UILabel!
    @IBOutlet weak var houseWarCard3Label: UILabel!
    
    @IBOutlet weak var playerWarCard1Label: UILabel!
    @IBOutlet weak var playerWarCard2Label: UILabel!
    @IBOutlet weak var playerWarCard3Label: UILabel!
    
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
        if let title = sender.titleLabel
        {
            if title.text == "Let's Play!"
            {
                self.newGame()
            }
            else if title.text == "Continue"
            {
                if self.winnerLabel.text == "It's a war!"
                {
                    self.war()
                }
                else
                {
                    self.prepForNextTurn()
                }
                //I would kind of love to just make this a generic tap gesture on the view, so tap anywhere to continue
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
        
        self.playContinueButton.setTitle("Continue", forState: UIControlState.Normal)
        self.playContinueButton.enabled = false
    }
    
    func prepForNextTurn()
    {
        self.houseCardInPlayLabel.text = ""
        self.houseCardInPlayLabel.hidden = true
        
        self.playerCardInPlayLabel.text = ""
        self.playerCardInPlayLabel.hidden = true
        
        self.dealer.cardsInPlay.removeAll()
        
        self.playContinueButton.enabled = false
        
        self.playerCard1Label.userInteractionEnabled = true
        self.playerCard2Label.userInteractionEnabled = true
        self.playerCard3Label.userInteractionEnabled = true
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
        }
    }
    
    func card1Tapped()
    {
        //        if let card1Label = self.playerCard1Label.text
        //        {
        self.setCardToPlay(self.playerCard1Label)
        //        }
    }
    
    func card2Tapped()
    {
        //        if let card2Label = self.playerCard2Label.text
        //        {
        self.setCardToPlay(self.playerCard2Label)
        //        }
    }
    
    func card3Tapped()
    {
        //would I be able to get all three of these methods combined to one?
        
        //        if let card3Label = self.playerCard3Label.text
        //        {
        self.setCardToPlay(self.playerCard3Label)
        //        }
    }
    
    func setCardToPlay(label: UILabel)
    {
        print("house deck: \(self.dealer.house.cardsInDeck.count) \n house hand: \(self.dealer.house.cardsInHand.count) \n player deck: \(self.dealer.player.cardsInDeck.count) \n player hand: \(self.dealer.player.cardsInHand.count) \n ________________ \n total: \(self.dealer.house.cardsInDeck.count + self.dealer.house.cardsInHand.count + self.dealer.player.cardsInDeck.count + self.dealer.player.cardsInHand.count)")
        
        for i in 0..<self.dealer.player.cardsInHand.count
        {
            let card = self.dealer.player.cardsInHand[i]
            if let cardLabel = label.text
            {
                if card.cardLabel == cardLabel
                {
                    label.text = ""
                    label.hidden = true
                    
                    self.turn(self.dealer.player.cardsInHand.removeAtIndex(i))
                    
                    break
                }
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
        
        self.playContinueButton.enabled = true
        
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
    
    func war()
    {
        self.playContinueButton.enabled = false
        self.dealer.war()
        
        switch self.dealer.house.cardsForWar.count
        {
        case 2:
            //set first two labels plus unhide them
            self.houseWarCard1Label.text = self.dealer.house.cardsForWar[0].cardLabel
            self.houseWarCard2Label.text = self.dealer.house.cardsForWar[1].cardLabel
            
            self.houseWarCard1Label.hidden = false
            self.houseWarCard2Label.hidden = false
        case 1:
            self.houseWarCard1Label.text = self.dealer.house.cardsForWar[0].cardLabel
            
            self.houseWarCard1Label.hidden = false
            //don't forget case 0!!!!
        default:
            self.houseWarCard1Label.text = self.dealer.house.cardsForWar[0].cardLabel
            self.houseWarCard2Label.text = self.dealer.house.cardsForWar[1].cardLabel
            self.houseWarCard3Label.text = self.dealer.house.cardsForWar[2].cardLabel
            
            self.houseWarCard1Label.hidden = false
            self.houseWarCard2Label.hidden = false
            self.houseWarCard3Label.hidden = false
        }
        //we have a war!
        //this means i have up to 8 cards on deck--3 each or so for the facedown
        //one for the card to play
        //this method should populate the new label views with the card values/cardbacks
        //then it should call award() again on them
    }
    //once award() has been called again, it goes through the motions.  when it's been awarded, we should check to see if there's a war that's in play (a calculated property called isWar:Bool, or one we set ourselves here)
    //somehow the Continue button should know to change the Message to "Reveal cards!" to turn the facedown cards right side up so you know what you've lost/won
    //then the continue button should go like normal and clear the field
    //if there's been another war, the same thing happens again, but there has to be a layer of cards underneath that gets revealed after the top layer has been, and so on.
    //i can figure that out later though
    
    /*
     Okay.  So the game mostly works.  It doesn't handle wars at all, and it freaked out near the endgame--I can't remember properly, but I think I tapped on the deck for player as usual to draw the hand and it crashed.  Index out of range, it said.
     
     I should deal with wars, though.  And then worry about winning/finishing the game.
     */
}
