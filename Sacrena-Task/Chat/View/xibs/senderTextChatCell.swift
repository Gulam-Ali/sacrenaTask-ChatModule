//
//  senderTextChatCell.swift
//  Sacrena-Task
//
//  Created by Gulam Ali on 16/09/24.
//

import UIKit

class senderTextChatCell: UITableViewCell {
    
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var messageView: UIView!{
        didSet{
            messageView.roundCorners(corners: [.topLeft, .topRight, .bottomLeft], radius: 16.0)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
