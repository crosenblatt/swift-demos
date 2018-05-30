//
//  ViewController.swift
//  ToDoApp
//
//  Created by Christopher Rosenblatt on 5/30/18.
//  Copyright © 2018 crosenblatt. All rights reserved.
//

import UIKit
import os.log

class ViewController: UIViewController {
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var todoField: UITextField!

    var todoItem:String?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender:Any?) {
        super.prepare(for:segue, sender:sender)
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("save not pressed, cancelling", log: OSLog.default, type: .debug)
            return
            
        }
        
        todoItem = todoField.text ?? ""
        
        
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

