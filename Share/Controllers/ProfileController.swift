//
//  ProfileController.swift
//  Share
//
//  Created by Caryl Rabanos on 07/09/2018.
//  Copyright © 2018 Caryl Rabanos. All rights reserved.
//

import UIKit

class ProfileController: UIViewController {
    
    @IBOutlet weak var button : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func MapsAction(_ sender: UIButton) {
    
            self.performSegue(withIdentifier: "MapsSegue", sender: self)
    }
}
