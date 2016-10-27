//
//  ChatViewController.swift
//  ParseChatter
//
//  Created by James Zhou on 10/26/16.
//  Copyright © 2016 James Zhou. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var messageTextField: UITextField!
    
    @IBOutlet weak var chatTableView: UITableView!
    
    var messages =  [PFObject]()
    
    let className = "Message"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(onTimer), userInfo: nil, repeats: true)
        
        self.chatTableView.dataSource = self
        self.chatTableView.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSend(_ sender: Any) {
        
        let message = PFObject(className: className)
        message["text"] = messageTextField.text
        
        message["user"] = PFUser.current()
        
        
        
        message.saveInBackground { (isScuess: Bool, error: Error?) in
            print("save msg: \(self.messageTextField.text) is successful: \(isScuess)")
        }
    }
    
    // MARK: - Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        
        let object = self.messages[indexPath.row]
        
        if let s = object["text"] as? String {
            cell.messageLabel.text = s
        } else {
            cell.messageLabel.text = "NOT A STRINGGGGG"
        }
        
        if let u = object["user"] as? PFUser {
            cell.usernameLabel.text = u.username
        }
        
        
        
        return cell
    }
    
    func onTimer() {
        
        let query = PFQuery(className: className)
        query.order(byDescending: "createdAt")
        query.includeKey("user")
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            
            if (objects != nil) {
                if ((objects?.count)! > 0) {
                    self.messages = objects!
                    self.chatTableView.reloadData()
                }
            }
            }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
