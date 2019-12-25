//
//  SignUpViewController.swift
//  LoginEmail
//
//  Created by Van on 12/16/19.
//  Copyright © 2019 Van. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
class SignUpViewController: UIViewController {
    @IBOutlet weak var FirstNameTextField: UITextField!
    @IBOutlet weak var LastNameTextField: UITextField!
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var SignUpButton: UIButton!
    @IBOutlet weak var ErrorLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        }
    func setUpElements()  {
        ErrorLabel.alpha = 0
        Utilities.styleTextField(FirstNameTextField)
        Utilities.styleTextField(LastNameTextField)
        Utilities.styleTextField(EmailTextField)
        Utilities.styleTextField(PasswordTextField)
        Utilities.styleFilledButton(SignUpButton)
    }
    func validateFields() -> String? {
        //check that all text fields are filled  in
        if FirstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || LastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || EmailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || PasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "please fill in all friends"
        }
        //check if the password is secure
        let cleandedPassword = PasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isPasswordValid(cleandedPassword) == false {
            //password isn't secure enough
            return "please make sureyour password is at least 8 characters , contains a special character and a number"
        }
        return nil
    }
    func showError(_ message: String) {
        ErrorLabel.text = message
        ErrorLabel.alpha = 1
    }
    @IBAction func SignUpTapped(_ sender: Any) {
        //validate the fields
        let error = validateFields()
        if error != nil {
            //there's somthing wrong with the fields , show error message
            showError(error!)
        }else{
            let firstName = FirstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = LastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = EmailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = PasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            //create users
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                if err != nil {
                    self.showError("Error creating user")
                }else{
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: [
                         "firstname": firstName,
                         "lastname": lastName,
                         "uid": result!.user.uid
                     ]) { (error) in
                         if  error != nil {
                            self.showError("Error saving User data")
                         }
                     }
                    //transition to the home sreen
                    self.transitionToHome()
                }
            }
        }
    }
    func transitionToHome() {
        let homeVC = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController)  as? HomeViewController
        view.window?.rootViewController = homeVC
        view.window?.makeKeyAndVisible()
    }
}
