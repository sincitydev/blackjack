//
//  GameTableViewController.swift
//  Blackjack
//
//  Created by Joshua Ramos on 10/1/17.
//  Copyright © 2017 Krevalent. All rights reserved.
//

import UIKit

class GameTableViewController: UIViewController {

    @IBOutlet weak var bettingSlider: UISlider!
    @IBOutlet weak var bettingLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    
    var playersMoney = 500
    var blackjackGame = BlackjackBrain()
    var playersHand = [card]()
    var dealersHand = [card]()
    
    
    
    var playerCardViews = [UIImageView]()
    var dealersCardViews = [UIImageView]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        moneyLabel.text = getMoneyString(forInt: playersMoney)
        bettingSlider.value = 0
        bettingSlider.maximumValue = Float(playersMoney)
        
        let hitGetstureRecgonizer = UISwipeGestureRecognizer(target: self, action: #selector(hit))
        
        let stayGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(stay))
        
        stayGestureRecognizer.numberOfTapsRequired = 2
        
        hitGetstureRecgonizer.direction = .down
        
        view.addGestureRecognizer(hitGetstureRecgonizer)
        view.addGestureRecognizer(stayGestureRecognizer)
        
    }
    
    @objc func hit(sender: UISwipeGestureRecognizer) {
        
        if playersHand.count == 0 {
            print("Need to deal before I can hit you")
        } else {
            print("Hit me")
        blackjackGame.hitPlayer()
        }
    }
    
    @objc func stay(sender: UITapGestureRecognizer) {
        
        if dealersHand.count == 0 {
            print("Need to deal before you can stay")
        } else {
            print("Stay")
        }
    }
    
    
    @IBAction func sliderAction(_ sender: UISlider) {
        bettingLabel.text = "Betting: $\(sender.value.rounded())"
        let newTotal = playersMoney - Int(sender.value.rounded())
        moneyLabel.text = "\(newTotal)"
        
    }
    
    

    @IBAction func dealButtonPressed(_ sender: Any) {
        
        playersMoney = Int(moneyLabel.text!)!
        bettingSlider.maximumValue = Float(playersMoney)
        bettingSlider.value = 0
        blackjackGame.deal()
        playersHand = blackjackGame.getPlayersHand()
        dealersHand = blackjackGame.getDealersHand()
        
        var xOffset: CGFloat = 10
        var yOffset: CGFloat = self.view.bounds.size.height - 148
        var fadeOffset:TimeInterval = 0.1
        
        for i in 1...11 {
            let cardView = UIImageView(frame: CGRect(x: self.view.bounds.size.width + 100, y: yOffset, width: 100, height: 128))
            cardView.image = UIImage(named: "\(i)_of_hearts")
            cardView.layer.shadowColor = UIColor.black.cgColor
            cardView.layer.shadowOffset = CGSize(width: 1, height: 1)
            cardView.layer.shadowOpacity = 0.70
            view.addSubview(cardView)
            
   
            UIView.animate(withDuration: fadeOffset, animations: {
                cardView.frame = CGRect(x: xOffset, y: yOffset, width: 100, height: 128)
            })
            
            playerCardViews.append(cardView)
            
            xOffset += 25
            yOffset += 0
            fadeOffset += 0.15
        }
        
        xOffset = self.view.bounds.size.width - 120
        yOffset = 20
        fadeOffset = 0.1

        for i in 1...11 {
            let cardView = UIImageView(frame: CGRect(x: -100, y: yOffset, width: 100, height: 128))
            if i == 1 {
                cardView.image = UIImage(named: "2_of_spades")
            } else {
                cardView.image = UIImage(named: "card_backing")
            }
            cardView.layer.shadowColor = UIColor.black.cgColor
            cardView.layer.shadowOffset = CGSize(width: 1, height: 1)
            cardView.layer.shadowOpacity = 0.70

            view.addSubview(cardView)
            
            UIView.animate(withDuration: fadeOffset, animations: {
                cardView.frame = CGRect(x: xOffset, y: yOffset, width: 100, height: 128)
            })
            
            dealersCardViews.append(cardView)
            
            xOffset -= 25
            yOffset -= 0
            fadeOffset += 0.15
        }
    }
    
    func getMoneyString(forInt: Int) -> String {
        return "$\(forInt)"
        
    }
    
    
    
    
}
