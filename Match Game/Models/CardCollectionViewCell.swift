//
//  CardCollectionViewCell.swift
//  Match Game
//
//  Created by Jordi Farras Mañe on 22/01/2019.
//  Copyright © 2019 Jordi Farras Mañe. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var frontImageView: UIImageView!
    
    @IBOutlet weak var backImageView: UIImageView!
    
    var card:Card?
    
    func  setCard(_ card:Card){
        self.card = card
        
        if  card.isMatched {
            backImageView.alpha = 0
            frontImageView.alpha = 0
            
            return
        }
        frontImageView.image = UIImage(named: card.imageName ?? "")
        
       /* if card.isFlipped  {
            UIView.transition(from: backImageView, to: frontImageView, duration: 0.3, options: [.transitionFlipFromLeft,.showHideTransitionViews], completion: nil)
            card.isFlipped = true
        }
        else{
            UIView.transition(from: frontImageView, to: backImageView, duration: 0.3, options: [.transitionFlipFromRight,.showHideTransitionViews], completion: nil)
            card.isFlipped = true
           

        }
 */
    }
    
    func flip() {
        UIView.transition(from: backImageView, to: frontImageView, duration: 0.3, options: [.transitionFlipFromLeft,.showHideTransitionViews], completion: nil)
       // card?.isFlipped = true
    }
    
    func flipBack() {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5){
            UIView.transition(from: self.frontImageView, to: self.backImageView, duration: 0.3, options: [.transitionFlipFromRight,.showHideTransitionViews], completion: nil)
        
        //card?.isFlipped = false
        }
    }
    
    func remove() {
        
        UIView.animate(withDuration: 0.3,delay:0.5,options:.curveEaseOut, animations:   {
            self.frontImageView.alpha = 0
        },completion:nil)
       
    }
}
