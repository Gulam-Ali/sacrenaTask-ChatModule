//
//  recentChatVM.swift
//  Sacrena-Task
//
//  Created by Gulam Ali on 16/09/24.
//

import Foundation
import StreamChat

protocol recentChatVMProtocol : AnyObject {
    func didGetError(error:String)
    func didGetRecentChannels()
}

final class recentChatsVM {
    
    unowned var delegate : recentChatVMProtocol!
    var chatChannels : LazyCachedMapCollection<ChatChannel>? = nil
    
    //Query stream channels by lastMessageAt
     var getRecentChatChannels: Void{
        let controller = ChatClient.shared.channelListController(
            query: .init(
                filter: .and([.equal(.type, to: .messaging), .containMembers(userIds: ["alice-9650"])]),
                sort: [.init(key: .lastMessageAt, isAscending: false)],
                pageSize: 10
            )
        )

        controller.synchronize { [self] error in
            if let error = error {
                // handle error
                print(error)
                delegate.didGetError(error: error.localizedDescription)
            } else {
                // access channels
                chatChannels = !controller.channels.isEmpty ? controller.channels : nil
                print(controller.channels.map({$0.cid}))
                
                // load more if needed
                controller.loadNextChannels(limit: 10) { error in
                    // handle error / access channels
                }
                
                delegate.didGetRecentChannels()
            }
        }
    }
    
}
