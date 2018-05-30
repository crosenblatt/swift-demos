//
//  TodoTableViewController.swift
//  ToDoApp
//
//  Created by Christopher Rosenblatt on 5/30/18.
//  Copyright © 2018 crosenblatt. All rights reserved.
//

import UIKit
import os.log

class TodoTableViewController: UITableViewController {
    var items = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "TodoItemTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TodoItemTableViewCell else {
            fatalError("No good")
        }
        
        let item = items[indexPath.row]
        
        // Configure the cell...
        cell.todoLabel.text = item

        return cell
    }
 
    @IBAction func unwindToList(sender: UIStoryboardSegue) {
        if let source = sender.source as? ViewController, let todoItem = source.todoItem {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                items[selectedIndexPath.row] = todoItem
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                let newIndexPath = IndexPath(row: items.count, section: 0)
                items.append(todoItem)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
 


    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
  */


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            case "AddItem":
                os_log("Adding new item", log: OSLog.default, type: .debug)
            
            case "ShowDetail":
                guard let detailViewController = segue.destination as? ViewController else {
                    fatalError("Unexpected dest")
                }
            
                guard let selectedCell = sender as? TodoItemTableViewCell else {
                    fatalError("Unexpected sender")
                }
            
                guard let indexPath = tableView.indexPath(for: selectedCell) else {
                    fatalError("Not displayed by table")
                }
            
                let selected = items[indexPath.row]
                detailViewController.todoItem = selected
            
            default:
                fatalError("oops")
        }
        
    }

}
