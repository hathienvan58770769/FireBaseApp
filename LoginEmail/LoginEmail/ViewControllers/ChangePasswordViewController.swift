//
//  ChangePasswordViewController.swift
//  LoginEmail
//
//  Created by Van on 12/24/19.
//  Copyright © 2019 Van. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController {

    @IBAction func BackButton(_ sender: Any) {
         navigationController?.popViewController(animated: true)
    }
    @IBOutlet weak var CurrentPasswordTextField: UITextField!
    @IBOutlet weak var NewPasswordTextField: UITextField!
    @IBOutlet weak var ConfirmNewPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElement()
        
    }
    func setUpElement() {
        Utilities.styleTextField(CurrentPasswordTextField)
        Utilities.styleTextField(NewPasswordTextField)
        Utilities.styleTextField(ConfirmNewPasswordTextField)

    }
    
}
