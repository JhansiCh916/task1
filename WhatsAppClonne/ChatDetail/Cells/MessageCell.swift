//
//  MessageCell.swift
//  WhatsAppClonne
//
//  Created by Jhansi Ch on 01/06/24.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var messageText: UILabel!
    @IBOutlet weak var messageView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        messageView.layer.cornerRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
