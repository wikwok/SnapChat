//
//  SelectUserViewController.swift
//  SnapChat
//
//  Created by Salih Alborno on 12/06/2017.
//  Copyright © 2017 test. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class SelectUserViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var users : [User] = []
    
    var imageURL = ""
    var descrip = ""
    var uuid = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        // Do any additional setup after loading the view.
        Database.database().reference().child("users").observe(DataEventType.childAdded, with: { (snapshot) in
            
            print(snapshot)
            
            let user = User()
            user.uid = snapshot.key
            print(user.uid)
            
            let snapDict = snapshot.value as? [String:AnyObject] ?? [:]
            user.email = snapDict["email"] as! String
            print(user.email)
            
            //test // reduandant code
            for child in snapshot.children {
                let snap = child as! DataSnapshot //each child is a snapshot
                //let dict = snap.value as! [String:AnyObject] //the value is a dictionaly
                print("snap children: \(snap)")
            }
            
            
            //let snapshotemailvalue = snapshot.value! as? [String:String]
              //  print(snapshotemailvalue as Any)
            //user.email = (snapshotemailvalue?["email"])! as String
               print(user.email)
            //user.email = snapshot.value["email"] as! String //does not work! From instructor code
            //user.uid = snapshot.key
                print(user.uid)
            
            self.users.append(user)
            
            self.tableView.reloadData()
            
            
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let user = users[indexPath.row]
        cell.textLabel?.text = user.email
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        let snap = ["from":Auth.auth().currentUser?.email, "description":descrip, "imageURL":imageURL, "uuid":uuid]
        Database.database().reference().child("users").child(user.uid).child("snaps").childByAutoId().setValue(snap)
        navigationController?.popToRootViewController(animated: true)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        self.tableView.dataSource = self
        self.tableView.delegate = self
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
