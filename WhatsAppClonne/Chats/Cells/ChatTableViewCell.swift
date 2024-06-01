//
//  ChatTableViewCell.swift
//  WhatsAppClonne
//
//  Created by Jhansi Ch on 29/05/24.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var avatar: UIView!
    @IBOutlet weak var conatctMsg: UILabel!
    @IBOutlet weak var contactName: UILabel!
    @IBOutlet weak var contactImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backView.layer.cornerRadius = 8
        avatar.layer.cornerRadius = 12
        contactImg.layer.cornerRadius = 12
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
