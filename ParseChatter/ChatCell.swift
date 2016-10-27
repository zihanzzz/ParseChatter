//
//  ChatCell.swift
//  ParseChatter
//
//  Created by James Zhou on 10/26/16.
//  Copyright © 2016 James Zhou. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
