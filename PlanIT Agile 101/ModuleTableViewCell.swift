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
    @IBOutlet weak var ImageView: UIImageView!
    var IdLabel: Int!
    let logo = UIImage(named: "open-book")

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        ImageView.image = logo
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
