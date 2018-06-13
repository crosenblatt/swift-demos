//
//  ViewController.swift
//  messagingapp
//
//  Created by Christopher Rosenblatt on 6/12/18.
//  Copyright © 2018 crosenblatt. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var ref:DatabaseReference?
    var dataBaseHandle:DatabaseHandle?
    var postData = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        ref = Database.database().reference()
        
        //Retrieve posts and listen for changes
        dataBaseHandle = ref?.child("Posts").observe(.childAdded, with: { (snapshot) in
            //Executes when child is added
            
            //Take value from snapshot and add it to post data array
            let post = snapshot.value as? String
            
            if let actualPost = post {
                self.postData.append(actualPost)
                self.tableView.reloadData()
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell")
        cell?.textLabel?.text = postData[indexPath.row]
        return cell!
    }
    
    
}

