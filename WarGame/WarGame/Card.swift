//
//  Card.swift
//  WarGame
//
//  Created by Amy Joscelyn on 6/21/16.
//  Copyright © 2016 Amy Joscelyn. All rights reserved.
//

import Foundation

class Card
{
    class func validSuits() -> [String]
    {
        let spades = "♠️"
        let hearts = "♥️"
        let diamonds = "♦️"
        let clubs = "♣️"
        
        return [spades, hearts, diamonds, clubs]
    }
    
    class func validRanks() -> [String]
    {
        return ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]
    }
    
    let suit: String
    let rank: String
    let cardLabel: String
    let cardValue: Int
    
    var description: String
    {
        return self.cardLabel
    }
    
    init(suit: String, rank: String)
    {
        self.suit = suit
        self.rank = rank
        self.cardLabel = "\(suit)\(rank)"
        
        if rank == "J" || rank == "Q" || rank == "K"
        {
            self.cardValue = 10
        }
        else if rank == "A"
        {
            self.cardValue = 1
        }
        else
        {
            self.cardValue = Int(rank)!
        }
    }
}
