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
    
    @IBOutlet weak var timerLabel: UILabel!
    
    var model = CardModel()
    var cardArray = [Card]()
    
    var firstFlippedCardIndex:IndexPath?
    
    var timer:Timer?
    var milliseconds:Float = 10 * 1000
    
    var soundManager = SoundManager()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        cardArray = model.getCards()
        // Do any additional setup after loading the view, typically from a nib.
        timer = Timer.scheduledTimer(timeInterval:0.001, target:self,selector:#selector(timerElapsed),userInfo:nil,repeats:true)
        
        RunLoop.main.add(timer!,forMode:.common)
       // RunLoop.main.add(timer!,forMode:RunLoop.Mode)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        SoundManager.playSound(.shuffle)
    }
    @objc func timerElapsed(){
        
        milliseconds = milliseconds - 1
        
       let seconds =  String(format: "%.2f", milliseconds/1000)
        
        timerLabel.text = "Time Remaining \(seconds)"
        
        if milliseconds <= 0 {
            timer?.invalidate()
            
            timerLabel.textColor = UIColor.red
            
            
        }
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
        
        if milliseconds <= 0 {
            return
        }
        let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        
        let card = cardArray[indexPath.row]
        
        if (!card.isFlipped) {
            cell.flip()
            SoundManager.playSound(.flip)

            if firstFlippedCardIndex == nil {
                firstFlippedCardIndex = indexPath
            }
            else  {
                self.checkForMatches(indexPath)
            }
        }

    }
    
    // TODO: Match comparision
    
    func checkGameEnded() {
        
        var isWon = true
        
        for card in cardArray {
            
            if card.isMatched == false {
                isWon = false
                break
            }
        }
        
        var title = ""
        var message = ""
        
        if isWon == true {
            
            if milliseconds > 0 {
                timer?.invalidate()
            }
            
            title = "Game Over"
            message = "You've Lost!"
            
            self.showAlert(title, message)
        }
        else{
            
            if milliseconds > 0 {
                return
            }
            title = "Game Over"
            message = "You've Won!"
            self.showAlert(title, message)

            
        }
        
        
    }
    func showAlert(_ title:String, _ message:String) {
        let alert = UIAlertController(title:title,message:message,preferredStyle:.alert)
        
        let alertAction = UIAlertAction(title: "Ok",style:.default,handler:nil)
        
        alert.addAction(    alertAction)
        
        present(alert, animated: true)
    }
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
            
            checkGameEnded()
            //flip both
        }
        else {
            
            cardOne.isMatched = false
            cardTwo.isMatched = false
            
            cardOneCell?.flipBack()
            cardTwoCell?.flipBack()
        }
        
        if cardOneCell == nil {
            collectionView.reloadItems(at: [firstFlippedCardIndex!])
        }
        
        firstFlippedCardIndex = nil
    }
    
}

