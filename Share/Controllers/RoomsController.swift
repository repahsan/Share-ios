//
//  RoomsController.swift
//  Share
//
//  Created by Caryl Rabanos on 24/09/2018.
//  Copyright © 2018 Caryl Rabanos. All rights reserved.
//

import UIKit
import Firebase
let ref = Database.database().reference(fromURL: "https://share-a8ca4.firebaseio.com/")
var leader = [String]()
var members = [String]()
var dest = [String]()
var orig = [String]()
var numOfUser = [String]()
var Fare = [String]()
var myindex = 0
class RoomsController: UITableViewController {
    var roomId = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        ref.child("travel").queryOrdered(byChild: "Available").queryEqual(toValue: 1).observeSingleEvent(of: .value, with: {(snapshot) in
            if(dest.count != 0){
                dest.removeAll()
                orig.removeAll()
            }
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let roomid = snap.key
                let dict = snap.value as! [String: Any]
                let destination = dict["Destination"] as! String
                let origin = dict["Origin"] as! String
                    let fare = dict["Fare"] as! Int
                    let NumOfUser = dict["NoOfUsers"] as! String
                    self.roomId.append(roomid)
                    dest.append(destination)
                    orig.append(origin)
                    numOfUser.append(NumOfUser)
                    Fare.append(String(fare))
            }
            self.tableView.reloadData()
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return dest.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "healthyCell", for: indexPath)
            cell.textLabel?.text = "Destination:"+dest[indexPath.row]+",Origin:"+orig[indexPath.row]+",Fare:"+Fare[indexPath.row]+",Members:"+numOfUser[indexPath.row]
            print(roomId[indexPath.row])
            return cell
        }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myindex = indexPath.row
        id = roomId[indexPath.row]
        performSegue(withIdentifier: "RoomSegue", sender: self)
    }
    // MARK: - Table view data source

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
