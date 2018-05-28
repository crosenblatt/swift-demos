//
//  ViewController.swift
//  TipCalculator
//
//  Created by Christopher Rosenblatt on 5/25/18.
//  Copyright © 2018 crosenblatt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var tipField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var finalTotal: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func calculateTip(_ sender: Any) {
        let price:Double? = Double(priceField.text!)
        let tipPercentage:Int? = Int(tipField.text!)
        
        if price != nil && tipPercentage != nil {
            let tipDecimal:Double = Double(tipPercentage!) / 100.0
            let calculatedTip:Double = Double(price!) * tipDecimal
            resultLabel.text = String(format: "$%.2f", calculatedTip)
            finalTotal.text = String(format: "$%.2f", price! + calculatedTip)
        }
    }
}

