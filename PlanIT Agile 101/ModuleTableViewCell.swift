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
    //@IBOutlet weak var ImageView: UIImageView!
    var IdLabel: Int!
    @IBOutlet weak var buttonView: ButtonView!
    var imageName : String!

      
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
