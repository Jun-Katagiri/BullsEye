//
//  ViewController.swift
//  BullsEye
//
//  Created by Jun Katagiri on 2018/02/16.
//  Copyright © 2018年 Jun Katagiri. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentValue  = 50
    var targetValue = 0
    var score = 0
    var round = 0
    
    @IBOutlet weak var slider : UISlider!
    @IBOutlet weak var targetLabel : UILabel!
    @IBOutlet weak var scoreLabel : UILabel!
    @IBOutlet weak var roundLabel : UILabel!
    
    func startNewRound() {
        round += 1
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(50)
        updateLabel()
    }
    
    func updateLabel() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        startNewRound()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showAlert() {
        let difference = abs(currentValue - targetValue)
        
        var points = 100 - difference
        let title : String
        if difference == 0 {
            title = "Perfect!"
            points += 100
        } else if difference < 5 {
            title = "You almost had it!"
            points += 50
        } else if difference < 10 {
            title = "Pretty good!"
        } else {
            title = "Not even close..."
        }
        
        score += points
        
        let alert = UIAlertController(title: title,
        message: "The value of the slider is \(currentValue) \n" +
            "The target value is \(targetValue)" + "\nYou scored \(points) points.",
        preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Awesome", style: .default,
                                   handler: {action in self.startNewRound()})
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
//        startNewRound()
    }
    
    @IBAction func sliderMoved(_ sender: UISlider) {
        print("The value of the slider is now \(sender.value)")
        currentValue = lroundf(sender.value)
    }
    
    @IBAction func startOver() {
        currentValue  = 50
        targetValue = 0
        score = 0
        round = 0
        startNewRound()
    }
}

