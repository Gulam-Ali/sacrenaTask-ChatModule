//
//  ConnectionListVC.swift
//  Sacrena-Task
//
//  Created by Gulam Ali on 15/09/24.
//

import UIKit

class ConnectionListVC: UIViewController {
    
    //MARK: >>>>>> Outlets
    @IBOutlet weak var connectionListView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConnectionList
    }
    
    private var setupConnectionList: Void {
        get {
            connectionListView.register(UINib(nibName: "connectionListCell", bundle: nil), forCellReuseIdentifier: "connectionListCell")
            connectionListView.delegate = self
            connectionListView.dataSource = self
            connectionListView.tableFooterView = UIView()
            return
        }
    }

}

//MARK: >>>>>> UITableView Protocols
extension ConnectionListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "connectionListCell", for: indexPath) as! connectionListCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let story = UIStoryboard(name: "Main", bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: "ChatVC") as! ChatVC
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
