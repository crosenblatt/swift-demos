//
//  ComposeViewController.swift
//  messagingapp
//
//  Created by Christopher Rosenblatt on 6/12/18.
//  Copyright © 2018 crosenblatt. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ComposeViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    
    var ref:DatabaseReference?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addPost(_ sender: Any) {
        //Add Post to Firebase
        ref?.child("Posts").childByAutoId().setValue(textView.text)
        
        //Dismiss Popover
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelPost(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
