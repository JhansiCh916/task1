//
//  ImageCell.swift
//  WhatsAppClonne
//
//  Created by Jhansi Ch on 01/06/24.
//

import UIKit

class ImageCell: UITableViewCell {

    @IBOutlet weak var imagee: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        imagee.layer.cornerRadius = 8
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
