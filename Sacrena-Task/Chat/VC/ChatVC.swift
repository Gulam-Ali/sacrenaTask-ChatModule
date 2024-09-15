//
//  ChatVC.swift
//  Sacrena-Task
//
//  Created by Gulam Ali on 15/09/24.
//

import UIKit

class ChatVC: UIViewController {
    
    
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var sendButton: UIControl!
    @IBOutlet weak var camera: UIImageView!
    @IBOutlet weak var placeholderLabel: UILabel!
    @IBOutlet weak var placeholderInTextBox: UILabel!
    @IBOutlet weak var messageTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageView.layer.cornerRadius = messageView.frame.height/2
        messageView.layer.borderWidth = 1.0
        messageView.layer.borderColor = UIColor.lightGray.cgColor
        sendButton.layer.cornerRadius = sendButton.frame.width/2
        chatTableView.register(UINib(nibName: "textChatCell", bundle: nil), forCellReuseIdentifier: "textChatCell")
        chatTableView.register(UINib(nibName: "senderTextChatCell", bundle: nil), forCellReuseIdentifier: "senderTextChatCell")
        chatTableView.delegate = self
        chatTableView.dataSource = self
        chatTableView.tableFooterView = UIView()
        messageTextView.delegate = self
    }
    

    @IBAction func sendTapped(_ sender: Any) {
        
    }
    

}

//MARK: >>>>>> UITableView Protocols
extension ChatVC : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == 1){
            let cell = tableView.dequeueReusableCell(withIdentifier: "senderTextChatCell", for: indexPath) as! senderTextChatCell
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "textChatCell", for: indexPath) as! textChatCell
            return cell
        }

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

//MARK: >>>>>> TextView Protocol
extension ChatVC : UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        if textView.text != ""{
            placeholderInTextBox.isHidden = true
            sendButton.backgroundColor = UIColor.senderTheme
            textView.textColor = .white
            messageView.layer.borderColor = UIColor.white.cgColor
        }else{
            placeholderInTextBox.isHidden = false
            sendButton.backgroundColor = UIColor.lightGray
            textView.textColor = .lightGray
            messageView.layer.borderColor = UIColor.lightGray.cgColor
        }
        
    }
    
    
}
