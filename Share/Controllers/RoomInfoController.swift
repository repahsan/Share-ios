//
//  RoomInfoController.swift
//  Share
//
//  Created by Caryl Rabanos on 02/10/2018.
//  Copyright © 2018 Caryl Rabanos. All rights reserved.
//

import UIKit
import Firebase
var id = "";
class RoomInfoController: UIViewController {
    @IBOutlet weak var Origin: UILabel!
    @IBOutlet weak var Destination: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Origin.text = orig[myindex]
        Destination.text = dest[myindex]
        print(id)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
