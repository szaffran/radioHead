//
//  ArtistCell.swift
//  RadioHead
//
//  Created by Mac on 02/01/2018.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit

class ArtistCell: UITableViewCell {

    @IBOutlet weak var labelName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func fill(name : String){
        self.labelName.text = name
    }
    
    
}
