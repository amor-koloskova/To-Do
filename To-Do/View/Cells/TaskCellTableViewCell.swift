//
//  TaskCellTableViewCell.swift
//  To-Do
//
//  Created by Amor on 28.11.2023.
//

import UIKit

class TaskCellTableViewCell: UITableViewCell {
    
    @IBOutlet var symbol: UILabel!
    @IBOutlet var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
