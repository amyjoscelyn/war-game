//
//  House.swift
//  WarGame
//
//  Created by Amy Joscelyn on 6/21/16.
//  Copyright © 2016 Amy Joscelyn. All rights reserved.
//

import Foundation

class House: Player
{
    func cardToPlay()
    {
        let numberOfCardsInHand = UInt32(self.cardsInHand.count)
        
        if numberOfCardsInHand > 1
        {
            let randomNumber = Int(arc4random_uniform(numberOfCardsInHand))
            
            self.cardInPlay = self.cardsInHand.removeAtIndex(randomNumber)
        }
        else
        {
            self.cardInPlay = self.cardsInHand.removeAtIndex(0)
        }
        //later this can become more of a strategy thing
        //if i do decide to keep track of the player's last moves to decide on a strategy, then those need to become properties on the player
    }
}
