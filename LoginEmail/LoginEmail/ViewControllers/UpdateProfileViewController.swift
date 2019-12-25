//
//  UpdateProfileViewController.swift
//  LoginEmail
//
//  Created by Van on 12/24/19.
//  Copyright © 2019 Van. All rights reserved.
//

import UIKit

class UpdateProfileViewController: UIViewController {
    @IBAction func BackButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var UsernameLabel: UILabel!
    @IBOutlet weak var FirstNameTextField: UITextField!
    @IBOutlet weak var LastNameTextField: UITextField!
    @IBOutlet weak var GenderTextField: UITextField!
    @IBOutlet weak var DayOfBirthTextField: UITextField!
    @IBOutlet weak var EmailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElement()
    }
    func setUpElement() {
        Utilities.styleTextField(FirstNameTextField)
        Utilities.styleTextField(LastNameTextField)
        Utilities.styleTextField(GenderTextField)
        Utilities.styleTextField(DayOfBirthTextField)
        Utilities.styleTextField(EmailTextField)
        
        FirstNameTextField.rightViewMode = .always
        FirstNameTextField.rightView = UIImageView(image: UIImage(named: "name"))
        LastNameTextField.rightViewMode = .always
        LastNameTextField.rightView = UIImageView(image: UIImage(named: "name"))
        GenderTextField.rightViewMode = .always
        GenderTextField.rightView = UIImageView(image: UIImage(named: "gender"))
        DayOfBirthTextField.rightViewMode = .always
        DayOfBirthTextField.rightView = UIImageView(image: UIImage(named: "dayofbirth"))
        EmailTextField.rightViewMode = .always
        EmailTextField.rightView = UIImageView(image: UIImage(named: "email"))
    }
    
}
