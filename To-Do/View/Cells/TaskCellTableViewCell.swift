//
//  TaskCellTableViewCell.swift
//  To-Do
//
//  Created by Amor on 28.11.2023.
//

import UIKit

class TaskCellTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet var symbol: UILabel!
    @IBOutlet var title: UILabel!

}
