//
//  ViewController.swift
//  TwitterDemo
//
//  Created by Christopher Rosenblatt on 7/11/18.
//  Copyright © 2018 crosenblatt. All rights reserved.
//

import UIKit
import TwitterKit
import Social

class ViewController: UIViewController {

    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var unameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    var loginButton : TWTRLogInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        loginButton = TWTRLogInButton {(session, error) in
            if let asession = session {
                let client = TWTRAPIClient()
                client.loadUser(withID: asession.userID, completion: { (user, error) in
                    self.nameLabel.text = user?.name
                    self.unameLabel.text = asession.userName
                    
                    let imgURL = user?.profileImageURL
                    let url = URL(string: imgURL!)
                    let data = try?Data(contentsOf: url!)
                    self.profilePic.image = UIImage(data: data!)
                })
            } else {
                print("login error")
            }
            
        }
        
        loginButton.center = self.view.center
        self.view.addSubview(loginButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func sendTweet(_ sender: Any) {
        if TWTRTwitter.sharedInstance().sessionStore.hasLoggedInUsers() {
            let composer = TWTRComposerViewController.init(initialText: "Hello Twitter!", image: nil, videoURL: nil)
            self.present(composer, animated: true, completion: nil)
        }
    }
    
}

