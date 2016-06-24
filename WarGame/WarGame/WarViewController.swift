//
//  WarViewController.swift
//  WarGame
//
//  Created by Amy Joscelyn on 6/21/16.
//  Copyright © 2016 Amy Joscelyn. All rights reserved.
//

import UIKit

let card_back = "🐾"

class WarViewController: UIViewController
{
    @IBOutlet weak var winnerLabel: UILabel!
    
    @IBOutlet weak var houseDeckLabel: UILabel!
    @IBOutlet weak var houseCardInPlayLabel: UILabel!
    @IBOutlet weak var playerCardInPlayView: CardView!
    @IBOutlet weak var playerDeckLabel: UILabel!
    
    @IBOutlet weak var playerCard1View: CardView!
    @IBOutlet weak var playerCard2View: CardView!
    @IBOutlet weak var playerCard3View: CardView!
    
    @IBOutlet weak var houseWarCard1View: CardView!
    @IBOutlet weak var houseWarCard2View: CardView!
    @IBOutlet weak var houseWarCard3View: CardView!
    
    @IBOutlet weak var playerWarCard1View: CardView!
    @IBOutlet weak var playerWarCard2View: CardView!
    @IBOutlet weak var playerWarCard3View: CardView!
    
    @IBOutlet weak var playContinueButton: UIButton!
    
    
    //    @IBOutlet weak var cardView: CardView!
    
    
    let dealer: Dealer = Dealer.init()
    var cardViewXib: CardView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.winnerLabel.hidden = true
        self.houseDeckLabel.hidden = true
        self.playerDeckLabel.hidden = true
        self.houseCardInPlayLabel.hidden = true
        
        self.houseWarCard1View.hidden = true
        self.houseWarCard2View.hidden = true
        self.houseWarCard3View.hidden = true
        
        //Do I still need these...?
        self.playerCard1View.hidden = true
        self.playerCard2View.hidden = true
        self.playerCard3View.hidden = true
        self.playerCardInPlayView.hidden = true
        self.playerWarCard1View.hidden = true
        self.playerWarCard2View.hidden = true
        self.playerWarCard3View.hidden = true
        
        self.tapGestures()
    }
    
    func tapGestures()
    {
        let deckTapGesture = UITapGestureRecognizer(target: self, action: #selector(WarViewController.deckTapped))
        self.playerDeckLabel.addGestureRecognizer(deckTapGesture)
        
        let card1TapGesture = UITapGestureRecognizer(target: self, action: #selector(WarViewController.card1Tapped))
        self.playerCard1View.addGestureRecognizer(card1TapGesture)
        
        let card2TapGesture = UITapGestureRecognizer(target: self, action: #selector(WarViewController.card2Tapped))
        self.playerCard2View.addGestureRecognizer(card2TapGesture)
        
        let card3TapGesture = UITapGestureRecognizer(target: self, action: #selector(WarViewController.card3Tapped))
        self.playerCard3View.addGestureRecognizer(card3TapGesture)
    }
    
    @IBAction func playContinueButtonTapped(sender: UIButton)
    {
        //I would kind of love to just make this a generic tap gesture on the view, so tap anywhere to continue
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
            }
            else if title.text == "Resolve War"
            {
                self.resolveWar()
            }
            else if title.text == "Reveal Cards"
            {
                self.revealCards()
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
        self.winnerLabel.hidden = true
        
        self.playerCardInPlayView.card = nil
        //        self.playerCardInPlayLabel.hidden = true
        
        //*********************************
        // set all of the war cards as nil
        //*********************************
        
        self.houseWarCard1View.card = nil
        self.houseWarCard2View.card = nil
        self.houseWarCard3View.card = nil
        
        self.playerWarCard1View.card = nil
        self.playerWarCard2View.card = nil
        self.playerWarCard3View.card = nil
        
        self.dealer.cardsInPlay.removeAll()
        
        self.playContinueButton.enabled = false
        
        self.playerCard1View.userInteractionEnabled = true
        self.playerCard2View.userInteractionEnabled = true
        self.playerCard3View.userInteractionEnabled = true
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
            self.playerCard1View.card = self.dealer.player.cardsInHand[0]
            self.playerCard2View.card = self.dealer.player.cardsInHand[1]
            self.playerCard3View.card = self.dealer.player.cardsInHand[2]
            
            self.dealer.player.cardsInHand.removeAll()
        }
    }
    
    func card1Tapped()
    {
        self.determineCardToPlay(self.playerCard1View)
        self.playerCard1View.card = nil
    }
    
    func card2Tapped()
    {
        self.determineCardToPlay(self.playerCard2View)
        self.playerCard2View.card = nil
    }
    
    func card3Tapped()
    {
        self.determineCardToPlay(self.playerCard3View)
        self.playerCard3View.card = nil
    }
    
    func determineCardToPlay(cardView: CardView)
    {
        if let card = cardView.card
        {
            self.turn(card)
        }
    }
    
    func turn(card: Card)
    {
        self.dealer.player.cardInPlay = card
        self.playerCardInPlayView.card = card
        
        self.dealer.cardsInPlay.append(card)
        
        self.dealer.turn()
        
        self.houseCardInPlayLabel.text = self.dealer.house.cardInPlay?.cardLabel
        self.houseCardInPlayLabel.hidden = false
        
        self.playerCard1View.userInteractionEnabled = false
        self.playerCard2View.userInteractionEnabled = false
        self.playerCard3View.userInteractionEnabled = false
        
        //should I also disable the deck here?  or I can change the logic, so that it's not enabled until the hand/all three cardViews are empty...
        //the check might be trickier than I think though
        
        self.playContinueButton.enabled = true
        
        let message = self.dealer.award()
        self.winnerLabel.text = message
        self.winnerLabel.hidden = false
        
        if self.dealer.house.cardsInHand.count == 0 && self.dealer.player.cardsInHand.count != 0
        {
            self.dealer.round()
        }
    }
    
    func war()
    {
        //first phase
        //handler
        self.playContinueButton.enabled = false
        self.dealer.war()
        self.placeCardsFacedown()
    }
    
    func placeCardsFacedown()
    {
        self.winnerLabel.hidden = true
        //second phase
        switch self.dealer.house.cardsForWar.count
        {
        case 2:
            self.houseWarCard1View.card = self.dealer.house.cardsForWar[0]
            self.houseWarCard2View.card = self.dealer.house.cardsForWar[1]
        case 1:
            self.houseWarCard1View.card = self.dealer.house.cardsForWar[0]
        //don't forget case 0!!!!
        default:
            self.houseWarCard1View.card = self.dealer.house.cardsForWar[0]
            self.houseWarCard2View.card = self.dealer.house.cardsForWar[1]
            self.houseWarCard3View.card = self.dealer.house.cardsForWar[2]
            
            self.houseWarCard1View.faceUp = false
            self.houseWarCard2View.faceUp = false
            self.houseWarCard3View.faceUp = false
        }
        
        switch self.dealer.player.cardsForWar.count
        {
        case 2:
            //set first two labels plus unhide them
            self.playerWarCard1View.card = self.dealer.player.cardsForWar[0]
            self.playerWarCard2View.card = self.dealer.player.cardsForWar[1]
        case 1:
            self.playerWarCard1View.card = self.dealer.player.cardsForWar[0]
        //don't forget case 0!!!!
        default:
            self.playerWarCard1View.card = self.dealer.player.cardsForWar[0]
            self.playerWarCard2View.card = self.dealer.player.cardsForWar[1]
            self.playerWarCard3View.card = self.dealer.player.cardsForWar[2]
            
            self.playerWarCard1View.faceUp = false
            self.playerWarCard2View.faceUp = false
            self.playerWarCard3View.faceUp = false
        }
        
        self.playContinueButton.setTitle("Resolve War", forState: UIControlState.Normal)
        self.playContinueButton.enabled = true
        
        //can I remove the cards from cardsForWar now?
        //when are those cards added to cardsInPlay?
        //they need to be cleared before there's a chance of another war
    }
    
    func resolveWar()
    {
        //third phase
        
        self.playerCardInPlayView.card = self.dealer.player.cardInPlay
        self.houseCardInPlayLabel.text = self.dealer.house.cardInPlay?.cardLabel
        
        //        self.playContinueButton.enabled = false
        self.playContinueButton.setTitle("Reveal Cards", forState: UIControlState.Normal)
        
        let message = self.dealer.award()
        self.winnerLabel.text = message
        self.winnerLabel.hidden = false
    }
    
    func revealCards()
    {
        //fourth phase
        
        //        self.houseWarCard1Label.
        //reveal houseCards
        
        self.houseWarCard1View.faceUp = true
        self.houseWarCard2View.faceUp = true
        self.houseWarCard3View.faceUp = true
        
        self.playerWarCard1View.faceUp = true
        self.playerWarCard2View.faceUp = true
        self.playerWarCard3View.faceUp = true
        
        self.playContinueButton.setTitle("Continue", forState: UIControlState.Normal)
    }
    //if there's been another war, the same thing happens again, but there has to be a layer of cards underneath that gets revealed after the top layer has been, and so on.
    //i can figure that out later though
    
    //You know, it would be kind of cool to see the computer's cardsInHand as well, and to see which it chooses each turn
    //maybe it can go right at the top, and the winner bar can be translucent over it when it pops up, since those cards aren't interactive anyway
}
