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
    //var running = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        counter.text = String(count)
        stopButton.isEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        counter.text = String(count)
    }
    
    @objc func update() {
        count = count + 0.01
        counter.text = String(format: "%.2f", count)
    }
}

