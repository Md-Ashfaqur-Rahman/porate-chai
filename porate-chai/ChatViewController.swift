//
//  ChatViewController.swift
//  porate-chai
//
//  Created by Md Ashfaqur Rahman on 4/4/20.
//  Copyright © 2020 Md Ashfaqur Rahma. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {

    var chatcontainer = [String]()
    @IBOutlet weak var chat_TextField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func send_button_action(_ sender: Any) {
        chatcontainer.append(chat_TextField.text!)
        tableView.reloadData()
        chat_TextField.text = ""
    }
    
    

}
extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatcontainer.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatTableViewcell", for: indexPath)
        cell.textLabel?.text = chatcontainer[indexPath.row]
        return cell
    }
    
    
}
