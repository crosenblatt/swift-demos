//
//  TodoItemTableViewCell.swift
//  ToDoApp
//
//  Created by Christopher Rosenblatt on 5/30/18.
//  Copyright © 2018 crosenblatt. All rights reserved.
//

import UIKit

class TodoItemTableViewCell: UITableViewCell {
    //MARK: Properties
    @IBOutlet weak var todoLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
