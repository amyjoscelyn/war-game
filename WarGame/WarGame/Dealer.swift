//
//  Dealer.swift
//  WarGame
//
//  Created by Amy Joscelyn on 6/21/16.
//  Copyright © 2016 Amy Joscelyn. All rights reserved.
//

import Foundation

let half_the_deck = 26

class Dealer
{
    let deck: Deck
    let house: House
    let player: Player
    var cardsInPlay: [Card] = []
    
    init()
    {
        self.deck = Deck.init()
        self.house = House.init(name: "House")
        self.player = Player.init(name: "Player")
    }
    
    func deal()
    {
        self.player.cardsInDeck.removeAll()
        self.house.cardsInDeck.removeAll()
        
        self.deck.shuffle()
        
        for _ in 0..<half_the_deck
        {
            self.player.cardsInDeck.append(self.deck.drawCard())
            self.house.cardsInDeck.append(self.deck.drawCard())
        }
    }
    
    func round()
    {//as long as there is still at least a single card left in their deck this can be called
        if self.house.cardsInHand.count == 0
        {
            self.house.drawCardsToHand()
        }
        
        if self.player.cardsInHand.count == 0
        {
            self.player.drawCardsToHand()
        }
    }
    
    func turn()
    {
        self.house.cardToPlay()
        
        if let houseCard = self.house.cardInPlay
        {
            self.cardsInPlay.append(houseCard)
        }
        
        //the turn is simultaneous
        //house chooses the card from their hand to play
        //player is prompted to choose the card from their hand.  so this should be called when the player chooses their card.  its insertion onto the board should happen at the same time the house chooses their card and it gets inserted
        //card in play must be added to dealer's cardsInPlay
    }
    
    func award() -> String
    {
        var message = ""
        
        switch message
        {
        case "house":
            message = "House takes the hand!"
            self.house.cardsInDeck.appendContentsOf(self.cardsInPlay)
        case "player":
            message = "Player takes the hand!"
            self.player.cardsInDeck.appendContentsOf(self.cardsInPlay)
        case "war":
            message = "It's a war!"
            //run war method
        default:
            print("slipped through the cracks")
        }
        
        return message
    }
    
    func winner() -> String
    {
        var winner = ""
        //returns either "house", "player", or "war"
        var houseCardValue = 0
        if let houseCard = self.house.cardInPlay
        {
            houseCardValue = houseCard.cardValue
        }
        var playerCardValue = 0
        if let playerCard = self.house.cardInPlay
        {
            playerCardValue = playerCard.cardValue
        }
        
        if houseCardValue > playerCardValue
        {
            winner = "house"
        }
        else if houseCardValue < playerCardValue
        {
            winner = "player"
        }
        else
        {
            winner = "war"
            //i think.  this is assuming the card in play is never null at this point
        }
        return winner
    }
}
