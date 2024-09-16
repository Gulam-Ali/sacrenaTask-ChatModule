//
//  ChatVC.swift
//  Sacrena-Task
//
//  Created by Gulam Ali on 15/09/24.
//

import UIKit
import StreamChat
import PhotosUI

class ChatVC: UIViewController {
    
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var sendButton: UIControl!
    @IBOutlet weak var camera: UIImageView!
    @IBOutlet weak var placeholderLabel: UILabel!
    @IBOutlet weak var placeholderInTextBox: UILabel!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var username: UILabel!
    
    var channelData : ChatChannel!
    private var viewModel : chatVM?
    private var eventsController: EventsController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = chatVM(Channel: channelData)
        viewModel?.delegate = self
        setupUI
        setStreamChatData
    }
    
    private var setupUI: Void {
        get{
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
            let tap = UITapGestureRecognizer(target: self, action: #selector(backTapped))
            backImage.isUserInteractionEnabled = true
            backImage.addGestureRecognizer(tap)
            let camtap = UITapGestureRecognizer(target: self, action: #selector(cameraTapped))
            camera.isUserInteractionEnabled = true
            camera.addGestureRecognizer(camtap)
        }
    }
    
    @objc func backTapped(){
        eventsController = nil
        navigationController?.popViewController(animated: true)
    }
    
    @objc func cameraTapped(){
        var config = PHPickerConfiguration()
        config.selectionLimit = 1 // Set to 0 to allow multiple selections
        config.filter = .images // Filter for images
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    private var setStreamChatData: Void {
        get{
            username.text = viewModel?.senderName
            viewModel?.fetchMessages()
            watchStreamChannel()
        }
    }
    
    
    private func watchStreamChannel(){
        /// Channels are watched automatically when they're synchronized.
        
        /// 1: Create a `ChannelId` that represents the channel you want to watch.
        let channelId = ChannelId(type: .messaging, id: channelData.cid.id)
        
        /// 2: Use the `ChatClient` to create a `ChatChannelController` with the `ChannelId`.
        let channelController = ChatClient.shared.channelController(for: channelId)
        
        /// 3: Call `ChatChannelController.synchronize` to watch the channel.
        channelController.synchronize { [self] error in
            if let error = error {
                /// 4: Handle possible errors
                print(error)
            }else{
                eventsController = ChatClient.shared.eventsController()
                eventsController.delegate = self
            }
        }
    }
    
    func scrollToLastMessage() {
        let lastSectionIndex = chatTableView.numberOfSections - 1
        let lastRowIndex = chatTableView.numberOfRows(inSection: lastSectionIndex) - 1

        // Ensure the table has at least one row
        if lastRowIndex >= 0 {
            let indexPath = IndexPath(row: lastRowIndex, section: lastSectionIndex)
            chatTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }

    

    @IBAction func sendTapped(_ sender: Any) {
        self.view.endEditing(true)
        viewModel?.sendTextMessage(message: messageTextView.text ?? "")
    }
    
    
    

}

//MARK: >>>>>> PHPickerViewControllerDelegate
extension ChatVC : PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)
        
        for result in results {
            result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (object, error) in
                if let image = object as? UIImage {
                    DispatchQueue.main.async {
                        print("Image selected")
                    }
                }
            }
        }
    }
    
}

//MARK: >>>>>> UITableView Protocols
extension ChatVC : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.lastMessages.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let isByCurrentLoggedUser = viewModel?.lastMessages[indexPath.row].isSentByCurrentUser ?? false
        if isByCurrentLoggedUser{
            let cell = tableView.dequeueReusableCell(withIdentifier: "senderTextChatCell", for: indexPath) as! senderTextChatCell
            cell.message.text = viewModel?.lastMessages[indexPath.row].text ?? ""
            cell.timeLabel.text = viewModel?.lastMessages[indexPath.row].createdAt.formatted(date: .omitted, time: .shortened)
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "textChatCell", for: indexPath) as! textChatCell
            cell.message.text = viewModel?.lastMessages[indexPath.row].text ?? ""
            cell.timeLabel.text = viewModel?.lastMessages[indexPath.row].createdAt.formatted(date: .omitted, time: .shortened)
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
            sendButton.isUserInteractionEnabled = true
        }else{
            placeholderInTextBox.isHidden = false
            sendButton.backgroundColor = UIColor.lightGray
            textView.textColor = .lightGray
            messageView.layer.borderColor = UIColor.lightGray.cgColor
            sendButton.isUserInteractionEnabled = false
        }
        
    }
    
}


//MARK: >>>>>> Events
extension ChatVC : EventsControllerDelegate {
    func eventsController(_ controller: EventsController, didReceiveEvent event: Event) {
         switch event {
         case let event as MessageNewEvent:
             viewModel?.lastMessages.append(event.message)
             chatTableView.reloadData()
             scrollToLastMessage()
             
         default:
             break
         }
     }
}

//MARK: >>>>>> ChatVM Protocols
extension ChatVC : chatVMProtocol{
    
    func didReceiveNewMessage() {
        if viewModel?.lastMessages.count == 0 {
            chatTableView.isHidden = true
            placeholderLabel.isHidden = false
            placeholderLabel.text = "This is the beginning of your conversation with \(viewModel?.senderName ?? "")."
        }else{
            placeholderLabel.isHidden = true
            chatTableView.isHidden = false
            chatTableView.reloadData()
            scrollToLastMessage()
        }
    }
    
    func didGetError(error: String) {
        showAlert(withMessage: error)
    }
    
    func didSendMessageSuccessfully() {
        messageTextView.text = ""
        textViewDidChange(messageTextView)
    }

    
}
