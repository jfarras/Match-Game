//
//  ViewController.swift
//  Match Game
//
//  Created by Jordi Farras Mañe on 22/01/2019.
//  Copyright © 2019 Jordi Farras Mañe. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource {
  
    @IBOutlet weak var collectionView: UICollectionView!
    

    var model = CardModel()
    var cardArray = [Card]()
    var firstFlippedCardIndex:IndexPath?
    
    override func viewDidLoad() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        cardArray = model.getCards()

        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as! CardCollectionViewCell
        
        let card = cardArray[indexPath.row]
        
        cell.setCard(card)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        
        let card = cardArray[indexPath.row]
        
        if (!card.isFlipped) {
            cell.flip()

            if firstFlippedCardIndex == nil {
                firstFlippedCardIndex = indexPath
            }
            else  {
                self.checkForMatches(indexPath)
            }
        }
    }
    
    // TODO: Match comparision
    
    func checkForMatches(_ secondFlippedCardIndex: IndexPath) {
        
        //get the cells for the two caerds
        let cardOneCell = collectionView.cellForItem(at:firstFlippedCardIndex!) as? CardCollectionViewCell
        
        let cardTwoCell = collectionView.cellForItem(at:secondFlippedCardIndex) as? CardCollectionViewCell

        let cardOne = cardArray[firstFlippedCardIndex!.row]
        let cardTwo = cardArray[secondFlippedCardIndex.row]

        if cardOne.imageName == cardTwo.imageName {
            
            cardOne.isMatched = true
            cardTwo.isMatched = true
            
            cardOneCell?.remove()
            cardTwoCell?.remove()
            //flip both
        }
        else {
            
            cardOne.isMatched = false
            cardTwo.isMatched = false
            
            cardOneCell?.flipBack()
            cardTwoCell?.flipBack()
        }
        
        firstFlippedCardIndex = nil
    }
    
}

