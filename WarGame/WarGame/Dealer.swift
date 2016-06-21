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
        //the turn is simultaneous
        //
    }
}
