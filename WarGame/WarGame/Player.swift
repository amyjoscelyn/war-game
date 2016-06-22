//
//  Player.swift
//  WarGame
//
//  Created by Amy Joscelyn on 6/21/16.
//  Copyright © 2016 Amy Joscelyn. All rights reserved.
//

import Foundation

let cards_allowed_in_hand = 3

class Player
{
    let name: String
    var cardsInDeck: [Card] = []
    var cardsInHand: [Card] = []
    var cardInPlay: Card? //not sure if this should be optional or not... but there are times where there's no card in play, so that would be like nil, right?
    //I might want a description of the player... mostly this would keep track of how many cards left in the hand
    
    init(name: String)
    {
        self.name = name
    }
    
    func drawCardsToHand()
    {
        if self.cardsInDeck.count >= cards_allowed_in_hand
        {
            for i in 0..<cards_allowed_in_hand
            {
                self.cardsInHand.append(self.cardsInDeck.removeAtIndex(i))
            }
        }
        else
        {
            for i in 0..<self.cardsInDeck.count
            {
                self.cardsInHand.append(self.cardsInDeck.removeAtIndex(i))
            }
        }
        //does this cover what happens if there are no cards left?  i feel like that condition should be satisfied elsewhere, in a gameIsOver kind of way
    }
    
    //there should be a war method--like, how to handle a war
    
    //this method should be called at the end of each face-off, where the cardsInPlay are the param and are added to the winning player's deck
    func didWin(cards: [Card])
    {
        self.cardsInDeck.appendContentsOf(cards)
    }
}
