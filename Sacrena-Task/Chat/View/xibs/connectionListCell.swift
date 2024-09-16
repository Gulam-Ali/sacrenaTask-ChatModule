//
//  connectionListCell.swift
//  Sacrena-Task
//
//  Created by Gulam Ali on 15/09/24.
//

import UIKit
import StreamChat

class connectionListCell: UITableViewCell {
    
    
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var lastmessage: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var userimage: networkImage!
    
    var channelData : ChatChannel! {
        didSet{
            let sender = channelData.lastActiveMembers.filter({$0.id != streamChat.aliceID})
            let isOnline = sender.first?.isOnline ?? false
            statusView.backgroundColor = isOnline ? .green : .lightGray
            username.text = sender.first?.name ?? ""
            lastmessage.text = channelData.latestMessages.first?.text ?? ""
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        statusView.layer.cornerRadius = statusView.frame.width/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
