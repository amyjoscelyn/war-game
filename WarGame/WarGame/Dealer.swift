//
//  Dealer.swift
//  WarGame
//
//  Created by Amy Joscelyn on 6/21/16.
//  Copyright © 2016 Amy Joscelyn. All rights reserved.
//

import Foundation

let deck_size = 52
let cards_for_war = 3 //according to Bicycle, this should only be 1!
let card_for_play = 1

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
        
        for i in 0..<deck_size
        {
            if i % 2 == 0
            {
                self.player.cardsInDeck.append(self.deck.drawCard())
            }
            else
            {
                self.house.cardsInDeck.append(self.deck.drawCard())
            }
        }
        print("cards dealt out: \(self.player.cardsInDeck.count)")
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
    }
    
    func award() -> String
    {
        var message = ""
        
        print("house deck: \(self.house.cardsInDeck.count) \n house hand: \(self.house.cardsInHand.count) \n player deck: \(self.player.cardsInDeck.count) \n player hand: \(self.player.cardsInHand.count) \n ________________ \n total: \(self.house.cardsInDeck.count + self.house.cardsInHand.count + self.player.cardsInDeck.count + self.player.cardsInHand.count)")
        
        message = self.winner()
        
        switch message
        {
        case "house":
            message = "House wins!"
            self.house.cardsInDeck.appendContentsOf(self.cardsInPlay)
        case "player":
            message = "Player wins!"
            self.player.cardsInDeck.appendContentsOf(self.cardsInPlay)
        case "war":
            message = "It's a war!"
//            self.war()
        default:
            print("slipped through the cracks")
        }
        
        print("house deck: \(self.house.cardsInDeck.count) \n house hand: \(self.house.cardsInHand.count) \n player deck: \(self.player.cardsInDeck.count) \n player hand: \(self.player.cardsInHand.count) \n ________________ \n total: \(self.house.cardsInDeck.count + self.house.cardsInHand.count + self.player.cardsInDeck.count + self.player.cardsInHand.count)")
        
        return message
    }
    
    func winner() -> String
    {
        var winner = ""
        var houseCardValue = 0
        
        if let houseCard = self.house.cardInPlay
        {
            houseCardValue = houseCard.cardValue
        }
        var playerCardValue = 0
        if let playerCard = self.player.cardInPlay
        {
            playerCardValue = playerCard.cardValue
        }
        
        print("house has \(houseCardValue), player has \(playerCardValue)")
        
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
    
    func war()
    {
        //then a fourth card is played on top, and it determines the war
        //and this fourth is award()ed again
        if self.house.cardsInDeck.count >= cards_for_war + card_for_play
        {
            for i in 0..<cards_for_war
            {
                self.house.cardsForWar.append(self.house.cardsInDeck.removeAtIndex(i))
            }
            self.player.cardInPlay = self.player.cardsInDeck[0]
        }
        else if self.house.cardsInDeck.count > card_for_play
        {
            for i in 0..<self.house.cardsInDeck.count - card_for_play
            {
                self.house.cardsForWar.append(self.house.cardsInDeck.removeAtIndex(i))
            }
            self.player.cardInPlay = self.player.cardsInDeck[0]
        }
        else if self.house.cardsInDeck.count == card_for_play
        {
            self.house.cardInPlay = self.house.cardsInDeck[0]
        }
        else
        {
            //player automatically must win, because the house has run out of cards!
        }
        
        if self.player.cardsInDeck.count >= cards_for_war + card_for_play
        {
            for i in 0..<cards_for_war
            {
                self.player.cardsForWar.append(self.player.cardsInDeck.removeAtIndex(i))
            }
            self.player.cardInPlay = self.player.cardsInDeck[0]
        }
        else if self.player.cardsInDeck.count > card_for_play
        {
            for i in 0..<self.player.cardsInDeck.count - card_for_play
            {
                self.player.cardsForWar.append(self.player.cardsInDeck.removeAtIndex(i))
            }
            self.player.cardInPlay = self.player.cardsInDeck[0]
        }
        else if self.player.cardsInDeck.count == card_for_play
        {
            self.player.cardInPlay = self.player.cardsInDeck[0]
        }
        else
        {
            //house automatically must win, because you've run out of cards!
        }
        self.cardsInPlay.appendContentsOf(self.house.cardsForWar)
        self.cardsInPlay.appendContentsOf(self.player.cardsForWar)
        
        if let houseCard = self.house.cardInPlay
        {
            self.cardsInPlay.append(houseCard)
        }
        if let playerCard = self.player.cardInPlay
        {
            self.cardsInPlay.append(playerCard)
        }
    }
}
