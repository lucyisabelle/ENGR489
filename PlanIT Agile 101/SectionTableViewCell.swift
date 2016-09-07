//
//  SectionTableViewCell.swift
//  PlanIT Agile 101
//
//  Created by Lucy French on 16/06/16.
//  Copyright © 2016 Lucy French. All rights reserved.
//

import UIKit

class SectionTableViewCell: UITableViewCell {

    // MARK: Properties
    @IBOutlet weak var SectionNameLabel: UILabel!
    var sectionId = Int()
    @IBOutlet weak var progressView: ProgressView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
