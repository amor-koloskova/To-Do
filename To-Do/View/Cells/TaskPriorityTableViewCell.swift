//
//  TaskPriorityTableViewCell.swift
//  To-Do
//
//  Created by Amor on 29.11.2023.
//

import UIKit

class TaskPriorityTableViewCell: UITableViewCell {
    
    @IBOutlet var priorityTitle: UILabel!
    @IBOutlet var priorityDescription: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
