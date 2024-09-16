//
//  chatVM.swift
//  Sacrena-Task
//
//  Created by Gulam Ali on 16/09/24.
//

import Foundation
import StreamChat

protocol chatVMProtocol : AnyObject {
    func didGetError(error:String)
    func didSendMessageSuccessfully()
    func didReceiveNewMessage()
}


final class chatVM {
    
    unowned var delegate : chatVMProtocol!
    var lastMessages = [ChatMessage]()
    private var ChatChannel : ChatChannel
    init(Channel:ChatChannel) {
        ChatChannel = Channel
    }
    
    //Get sender's user name
    var senderName: String {
        let sender = ChatChannel.lastActiveMembers.filter({$0.id != "alice-9650"})
        return sender.first?.name ?? ""
    }
    
    func fetchMessages() {
        // Get or create a channel with its type and ID
        let channelId = ChannelId(type: .messaging, id: ChatChannel.cid.id)
        let channelController = ChatClient.shared.channelController(for: channelId)

        // Synchronize to fetch messages
        channelController.synchronize { [self] error in
            if let error = error {
                print("Failed to fetch channel messages: \(error)")
                delegate.didGetError(error: error.localizedDescription)
            } else {
                lastMessages = channelController.messages.reversed()
                delegate.didReceiveNewMessage()
            }
        }
    }
    
    //Send Text message in channel
    func sendTextMessage(message:String){
        let channelId = ChannelId(type: .messaging, id: ChatChannel.cid.id)
        let channelController = ChatClient.shared.channelController(for: channelId)
        channelController.createNewMessage(text: message) { [self] result in
            switch result {
            case .success(let messageId):
                print("Message ID - ",messageId)
                delegate.didSendMessageSuccessfully()
            case .failure(let error):
                print(error)
                delegate.didGetError(error: error.localizedDescription)
            }
        }
    }
    

}
