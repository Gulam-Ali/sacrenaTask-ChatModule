//
//  senderTextChatCell.swift
//  Sacrena-Task
//
//  Created by Gulam Ali on 16/09/24.
//

import UIKit

class senderTextChatCell: UITableViewCell {
    
    
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var messageView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        messageView.roundCorners(corners: [.topLeft,.topRight,.bottomLeft], radius: 20.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
