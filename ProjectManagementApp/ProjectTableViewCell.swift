//
//  ProjectTableViewCell.swift
//  ProjectManagementApp
//
//  Created by elaheh on 2017-08-02.
//  Copyright © 2017 elaheh. All rights reserved.
//

import UIKit

class ProjectTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var projectName: UILabel!
    
    @IBOutlet weak var projectStartDate: UILabel!
    
    
    @IBOutlet weak var projectEndDate: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
