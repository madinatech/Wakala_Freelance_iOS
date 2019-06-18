//
//  HomeCell.swift
//  PaytzWakala
//
//  Created by CrossGrids on 27/05/19.
//  Copyright © 2019 CrossGrids. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {

    @IBOutlet weak var btnView: UIButton!
   
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
   
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
