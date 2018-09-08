//
//  LoginController.swift
//  Share
//
//  Created by Caryl Rabanos on 06/09/2018.
//  Copyright © 2018 Caryl Rabanos. All rights reserved.
//

import UIKit
import Firebase
class LoginController: UIViewController {

    @IBOutlet weak var EmailTxtField: UITextField!
    @IBOutlet weak var PasswordTxtField: UITextField!
    
    @IBOutlet weak var emailReset: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func LoginAction(_ sender: UIButton) {
        guard let email = EmailTxtField.text, let password = PasswordTxtField.text
    else{
        print("form invalid")
        return
        }
        Auth.auth().signIn(withEmail: email, password: password, completion: {(user,error) in
            
            if error != nil{
                print(error?.localizedDescription as Any)
                return
            }
            self.performSegue(withIdentifier: "ProfileSegue", sender: self)
        })
    }
    @IBAction func ResetPasswordAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "resetPasswordSegue", sender: self)
    }
    @IBAction func resetPassword(_ sender: UIButton) {
        Auth.auth().sendPasswordReset(withEmail: emailReset.text!, completion: {(error) in
            if error != nil{
                print(error?.localizedDescription as Any)
                return
            }
        })
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
