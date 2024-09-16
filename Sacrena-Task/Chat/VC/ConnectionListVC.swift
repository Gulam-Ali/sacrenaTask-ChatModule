//
//  ConnectionListVC.swift
//  Sacrena-Task
//
//  Created by Gulam Ali on 15/09/24.
//

import UIKit
import StreamChat

class ConnectionListVC: UIViewController {
    
    //MARK: >>>>>> Outlets
    @IBOutlet weak var connectionListView: UITableView!
    
   private var viewModel = recentChatsVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConnectionList
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getRecentChats
    }
    
    //Setup recent chats list
    private var setupConnectionList: Void {
        get {
            connectionListView.register(UINib(nibName: "connectionListCell", bundle: nil), forCellReuseIdentifier: "connectionListCell")
            connectionListView.delegate = self
            connectionListView.dataSource = self
            connectionListView.tableFooterView = UIView()
            return
        }
    }
    
    private var getRecentChats: Void {
        get{
            viewModel.delegate = self
            viewModel.getRecentChatChannels
        }
    }
    
}

//MARK: >>>>>> UITableView Protocols
extension ConnectionListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.chatChannels?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "connectionListCell", for: indexPath) as! connectionListCell
        cell.channelData = viewModel.chatChannels?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let story = UIStoryboard(name: "Main", bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: "ChatVC") as! ChatVC
        vc.channelData = viewModel.chatChannels?[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

//MARK: >>>>>> RecentChats ViewModel Protocols
extension ConnectionListVC : recentChatVMProtocol {
    
    func didGetError(error: String) {
        showAlert(withMessage: error)
    }
    
    func didGetRecentChannels() {
        connectionListView.reloadData()
    }
    
}
