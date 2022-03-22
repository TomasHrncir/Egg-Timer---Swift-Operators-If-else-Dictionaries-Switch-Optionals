//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation //Add Sound

class ViewController: UIViewController {
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    
    let eggTimes = ["Soft": 30, "Medium": 40, "Hard": 70]
    var timer = Timer()
    var player: AVAudioPlayer!
    var totalTime = 0
    var secondsPassed = 0
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
                
        timer.invalidate()
        
        //Click on IBAction invalidate another IBAction w/ timer func
        let hardness = sender.currentTitle!//Soft, Medium, Hard
        totalTime = eggTimes[hardness]!
        

        progressBar.progress = 0.0 //Nastaveno jako Float a co to dela? Hold Option
        secondsPassed = 0
        titleLabel.text = hardness

        timer = Timer.scheduledTimer(timeInterval: 1.0, target:self, selector: #selector(updateTimer), userInfo:nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            secondsPassed += 1 //Tohle musi byt nad progressBar.progress = Float... abych se dostal na cislo 1
            progressBar.progress = Float(secondsPassed) / Float(totalTime) // Debug Console bezi do 1 3/4 nebo 4/5 a musi byt Float, tedy pohybliva
            print(Float(secondsPassed) / Float(totalTime))
        } else {
            timer.invalidate()
            titleLabel.text = "DONE!"
            
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
        }
    }
    
}
