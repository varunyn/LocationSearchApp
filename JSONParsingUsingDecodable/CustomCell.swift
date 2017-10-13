//
//  CustomCell.swift
//  JSONParsingUsingDecodable
//
//  Created by Varun Yadav on 10/12/17.
//  Copyright © 2017 Varun Yadav. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var addLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
