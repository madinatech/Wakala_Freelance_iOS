//
//  FormViewCell.swift
//  WakalaRegi
//
//  Created by CrossGrids on 07/06/19.
//  Copyright © 2019 CrossGrids. All rights reserved.
//

import UIKit

class FormViewCell: UITableViewCell {

    @IBOutlet weak var lblValue: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
