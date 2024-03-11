//
//  ViewController.swift
//  CatchKenny
//
//  Created by Kübra Akpunar (Teknoloji Mimarisi Bölümü) on 6.03.2024.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var imageKenny: UIImageView!
    @IBOutlet var highScore: UILabel!
    
    var timer = Timer()
    var count = 20
    var hScore = 5
    var newScore = 0
    var catchPic = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeLabel.text = "\(count)"
        highScore.text = "High Score: \(hScore)"
        scoreLabel.text = "Score: \(newScore)"
        
        timer = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(timerFunction), userInfo: nil, repeats: true)
        imageKenny.isUserInteractionEnabled = true

    }
    
    
    @objc func timerFunction() {
        count -= 1
        timeLabel.text = "\(count)"
        
        let minY = timeLabel.frame.maxY + 40
        let maxY = highScore.frame.minY - imageKenny.frame.height - 20
        let minX = CGFloat.random(in: 0...(view.frame.width - imageKenny.frame.width))
        let newY = CGFloat.random(in: minY...maxY)
        
        UIView.animate(withDuration: 0.6) {
            self.imageKenny.frame.origin = CGPoint(x: minX, y: newY)
        }
    
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageCatch(tapGestureRecognizer:)))
        imageKenny.isUserInteractionEnabled = true
        imageKenny.addGestureRecognizer(tapGestureRecognizer)
        
        if count <= 0 {
            timer.invalidate()
            timeLabel.text = "Time's over"
            let alert = UIAlertController(title: "Time's Over!", message: "Play again!", preferredStyle: .alert)
            let replayButton = UIAlertAction(title: "Replay", style: .default) { _ in
                self.count = 20
                self.catchPic = 0
                self.scoreLabel.text = "Score: \(self.catchPic)"
                self.timer = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(self.timerFunction), userInfo: nil, repeats: true)
            }
            alert.addAction(replayButton)
            present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func imageCatch(tapGestureRecognizer: UITapGestureRecognizer) {
        catchPic += 1
        scoreLabel.text = "Score: \(catchPic)"
        if catchPic >= hScore {
            hScore = catchPic
            highScore.text = "High Score: \(hScore)"
        }
    }
}
