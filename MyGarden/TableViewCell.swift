//
//  TableViewCell.swift
//  MyGarden
//
//  Created by Filipe Marques on 13/06/19.
//  Copyright © 2019 Filipe Marques. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var cellImage: UIImageView!
    
    @IBOutlet weak var cellTitle: UILabel!
    
    @IBOutlet weak var cellStatus: UILabel!
    
    @IBOutlet weak var cellCaret: UILabel!
    
    @IBOutlet weak var tempRange: UILabel!
    @IBOutlet weak var lumRange: UILabel!
    @IBOutlet weak var humRange: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
