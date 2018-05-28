//
//  ViewController.swift
//  Stopwatch
//
//  Created by Christopher Rosenblatt on 5/28/18.
//  Copyright © 2018 crosenblatt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var counter: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    var count = 0.0
    var timer = Timer()
    var minutes = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        counter.text = String(Int(count))
        stopButton.isEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func startAction(_ sender: Any) {
        stopButton.isEnabled = true
        startButton.isEnabled = false
        
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        
    }
    
    @IBAction func stopAction(_ sender: Any) {
        startButton.isEnabled = true
        stopButton.isEnabled = false
        
        timer.invalidate()
    }
    
    @IBAction func resetAction(_ sender: Any) {
        startButton.isEnabled = true
        stopButton.isEnabled = false
        
        timer.invalidate()
        count = 0.0
        minutes = 0
        counter.text = String(Int(count))
    }
    
    @objc func update() {
        count = count + 0.01
        if count >= 60 {
            minutes += 1
            count = 0
        }
        let seconds = Int(floor(count))
        let dec = count.truncatingRemainder(dividingBy: 1.0)
        counter.text = String(format: "\(minutes):%02d:%02.0f", seconds, dec * 100)
    }
}

