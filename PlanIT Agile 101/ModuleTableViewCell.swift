//
//  ModuleTableViewCell.swift
//  PlanIT Agile 101
//
//  Created by Lucy French on 6/06/16.
//  Copyright © 2016 Lucy French. All rights reserved.
//

import UIKit

class ModuleTableViewCell: UITableViewCell {
    
    // MARK: Properties
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var IdLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
