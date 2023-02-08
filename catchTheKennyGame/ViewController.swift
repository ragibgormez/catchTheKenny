//
//  ViewController.swift
//  catchTheKennyGame
//
//  Created by Ragıb Gormez on 4.02.2023.
//

import UIKit

class ViewController: UIViewController {
    
    
    //variables
    var score: Int = 0
    var timer = Timer()
    var counter = 0
    var kennyArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
    
    
    //views
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny9: UIImageView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = "Score: \(score)"
        
        
        //highScore check
        let storedHighScore = UserDefaults.standard.object(forKey: "highScore")
        if storedHighScore == nil {
            highScore = 0
            highScoreLabel.text = "High Score: \(highScore)"
        }
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highScoreLabel.text = "Highscore: \(highScore)"
        }
        
        
        
        //images
        kenny1.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        kenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        kenny9.isUserInteractionEnabled = true


        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        kenny1.addGestureRecognizer(recognizer1)
        kenny2.addGestureRecognizer(recognizer2)
        kenny3.addGestureRecognizer(recognizer3)
        kenny4.addGestureRecognizer(recognizer4)
        kenny5.addGestureRecognizer(recognizer5)
        kenny6.addGestureRecognizer(recognizer6)
        kenny7.addGestureRecognizer(recognizer7)
        kenny8.addGestureRecognizer(recognizer8)
        kenny9.addGestureRecognizer(recognizer9)
        
        kennyArray = [kenny1, kenny2, kenny3, kenny4, kenny5, kenny6, kenny7, kenny8, kenny9]
        
        
        //timers
        counter = 10
        timerLabel.text = String(counter)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
        
        hideKenny()
        
    }
    
    @objc func hideKenny() {
        for kenny in kennyArray {
            kenny.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(kennyArray.count - 1)))
        kennyArray[random].isHidden = false
                
        
        
        
    }
    
    
    @objc func countDown() {
        timerLabel.text = String(counter)
        counter -= 1
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            for kenny in kennyArray {
                kenny.isHidden = true
            }
            
            //highScore
            if self.score > self.highScore {
                self.highScore = self.score
                highScoreLabel.text = "High Score: \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highScore")
            }
            
            
            //alert
            let alert = UIAlertController(title: "Time's up", message: "your time's up", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "ok", style: UIAlertAction.Style.cancel)
            let playAgainButton = UIAlertAction(title: "replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
                
                //replay function
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 10
                self.timerLabel.text = String(self.counter)
        
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideKenny), userInfo: nil, repeats: true)
            }
            
            alert.addAction(okButton)
            alert.addAction(playAgainButton)
            
            self.present(alert, animated: true)
            
        }
    }
    
    
    
    @objc func increaseScore() {    //buraya bu fonksiyonu buton görünürde ise çalıştır tarzı bir şey ekleyeceğiz veya butonlarda bu fonksiyonu görünür olduğu zaman çalıştıran bir if ekleyeceğiz.
        score += 1
        scoreLabel.text = "Score: \(score)"
    }
    
    

    
}

