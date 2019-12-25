//
//  LoginViewController.swift
//  LoginEmail
//
//  Created by Van on 12/16/19.
//  Copyright © 2019 Van. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
class LoginViewController: UIViewController {
    
    @IBOutlet weak var EmailTextFields: UITextField!
    
    @IBOutlet weak var PasswordTextFields: UITextField!
    @IBOutlet weak var ErrorLabel: UILabel!
    @IBOutlet weak var LoginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }
   func setUpElements()  {
       ErrorLabel.alpha = 0
       Utilities.styleTextField(EmailTextFields)
       Utilities.styleTextField(PasswordTextFields)
       Utilities.styleFilledButton(LoginButton)
   }

    @IBAction func LoginTapped(_ sender: Any) {
        //Validate the text fields
        let email = EmailTextFields.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = PasswordTextFields.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        Auth.auth().signIn(withEmail: email, password: password) {
            (result, error) in
            if error != nil {
                self.ErrorLabel.text = error?.localizedDescription
                self.ErrorLabel.alpha = 1
                
            }else{
                self.transitionToHome()
            }
        }
        //signing in the user
    }
    func transitionToHome() {
        let homeVC = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController)  as? HomeViewController
        view.window?.rootViewController = homeVC
        view.window?.makeKeyAndVisible()
    }
    
}
