//
//  ForGotPasswordViewController.swift
//  LoginEmail
//
//  Created by Van on 12/19/19.
//  Copyright © 2019 Van. All rights reserved.
//

import UIKit
import FirebaseAuth
class ForGotPasswordViewController: UIViewController {

    @IBAction func BackButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBOutlet weak var EmailTexFiled: UITextField!
    @IBOutlet weak var ResetPasswordButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        
    }
   func setUpElements()  {
       Utilities.styleTextField(EmailTexFiled)
        EmailTexFiled.leftViewMode = .always
        EmailTexFiled.leftView = UIImageView(image: UIImage(named: "email"))
   }

    @IBAction func ResetPasswordTapped(_ sender: Any) {
        guard let email = EmailTexFiled.text, email != "" else{
            print("Error")
            return
            
        }
    }
    
    func resetPassword(email:String, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage:String) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) {
            (error) in
            if error == nil{
                onSuccess()
            }else{
                
            }
        }
    }
    
}
