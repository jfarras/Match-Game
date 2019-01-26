//
//  cardModel.swift
//  Match Game
//
//  Created by Jordi Farras Mañe on 22/01/2019.
//  Copyright © 2019 Jordi Farras Mañe. All rights reserved.
//

import Foundation

class CardModel {
    
    var generatedCardsArray = [Card]()
    
   
    func getCards() -> [Card] {
       
        for _ in 1...8 {
            let randomNumber = arc4random_uniform(13) + 1
            let cardOne = Card()
            cardOne.imageName = "card\(randomNumber)"
            
            let cardTwo = Card()
            cardTwo.imageName = "card\(randomNumber)"
            generatedCardsArray.append(cardTwo)
            
        }
        return generatedCardsArray
    }
}
