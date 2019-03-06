//
//  ItemTableViewCell.swift
//  BIWALK
//
//  Created by  on 27/2/19.
//  Copyright © 2019 Izaisa. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var etiquetaRutas: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
