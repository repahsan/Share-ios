//
//  ViewController.swift
//  Share
//
//  Created by Caryl Rabanos on 04/09/2018.
//  Copyright © 2018 Caryl Rabanos. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var fNameTxtField: UITextField!
    @IBOutlet weak var lNameTxtField: UITextField!
    @IBOutlet weak var contactNumberTxtField: UITextField!
    @IBOutlet weak var emergencyContactTxtField: UITextField!
    @IBOutlet weak var genderTxtField: UITextField!
    @IBOutlet weak var genderPicker: UIPickerView!
    
    let gender = ["Male","Female"]
    //--------------------------------------Gender Picker-------------------------------------------
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return gender[row]
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return gender.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        genderTxtField.text = gender[row]
        
    }
    //--------------------------------------------------------------------------------------------------
    override func viewDidLoad()
    {
        super.viewDidLoad()
        genderPicker.isHidden = true

    }
    @IBAction func GenderPickerShow(_ sender: UITextField)
    {
        genderPicker.isHidden = false
        genderTxtField.text = "Male"
    }
    @IBAction func AfterPickingGender(_ sender: UITextField)
    {
        genderPicker.isHidden = true
    }
    @IBAction func RegisterControl(_ sender: UIButton)
    {
        guard let email = emailTxtField.text, let password = passwordTxtField.text, let Fname = fNameTxtField.text, let Lname = lNameTxtField.text, let Gender = genderTxtField.text ,let Contact = contactNumberTxtField.text, let EmergencyContact = emergencyContactTxtField.text
            else{
            print("Form invalid!")
            return
        }
        //let contact:Int = Int(Contact)!
        //let eContact:Int = Int(EmergencyContact)!
        //--------------------------Validation for fields--------------------------------------------
        if email.count == 0 {
            self.createAlert(title: "No email", message: "Please enter email")
        }else if isValidEmail(email: email) == false {
            self.createAlert(title: "Invalid Email", message: "Wrong email format")
        }else if password.count < 6 {
            self.createAlert(title: "Password too short",message: "Password must be atleast 6 characters long")
        }else if Fname.count == 0 {
            self.createAlert(title: "No First Name", message: "Please enter First Name")
        }else if Lname.count == 0 {
            self.createAlert(title: "No Last Name", message: "Please enter Last Name")
        }else{
        //--------------------------------------------------------------------------------------------
            Auth.auth().createUser(withEmail: email, password: password, completion: {(user,error) in
                if error != nil{
                    print(error?.localizedDescription as Any)
                    return
                }
                let ref = Database.database().reference(fromURL: "https://share-a8ca4.firebaseio.com/")
                let values = ["Fname": Fname, "Lname": Lname, "Gender": Gender, "Contact Number": Contact,"Emergency Contract": EmergencyContact,"Pin":0] as [String : Any]
                let uid = Auth.auth().currentUser?.uid
                Auth.auth().currentUser?.sendEmailVerification(completion: {(error) in
                    if error != nil {
                        print(error?.localizedDescription as Any)
                        return
                    }
                ref.child("users").child(uid!).setValue(values, withCompletionBlock: {(err,ref) in
                    if err != nil{
                        print(err?.localizedDescription as Any)
                        return
                    }
                        self.performSegue(withIdentifier: "LoginSegue", sender: self)
                    })
                })
            })
            
        }
    }
    
    @IBAction func loginPage(_ sender: UIButton)
    {
        performSegue(withIdentifier: "LoginSegue", sender: self)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createAlert(title:String,message:String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let subButton = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        alert.addAction(subButton)
        self.present(alert, animated: true, completion: nil)
    }
    func isValidEmail(email:String)->Bool
    {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    func isValidNumber(contact:Int)->Bool
    {
        let contactRegEx = "^((\\+)|(00))[0-9]{6,14}$"
        let contactTest = NSPredicate(format:"SELF MATCHES %@", contactRegEx)
        return contactTest.evaluate(with:contact)
    }
    
}

