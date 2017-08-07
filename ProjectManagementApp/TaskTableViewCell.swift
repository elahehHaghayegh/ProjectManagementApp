//
//  TaskTableViewCell.swift
//  ProjectManagementApp
//
//  Created by elaheh on 2017-08-06.
//  Copyright © 2017 elaheh. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    
    @IBOutlet weak var labelTaskName: UILabel!
    @IBOutlet weak var labelTaskStatus: UILabel!
    @IBOutlet weak var labelStartDate: UILabel!
    @IBOutlet weak var labelEndDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
