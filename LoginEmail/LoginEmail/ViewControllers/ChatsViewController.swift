//
//  ChatsViewController.swift
//  LoginEmail
//
//  Created by Van on 12/20/19.
//  Copyright © 2019 Van. All rights reserved.
//

import UIKit

class ChatsViewController: UIViewController {

    @IBOutlet weak var AddFriendButton: UIButton!
    @IBOutlet weak var SearchTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
       
    }
    func setUpElements()  {
        Utilities.styleBackgroundTextField(SearchTextField)
        SearchTextField.leftViewMode = .always
        SearchTextField.leftView = UIImageView(image: UIImage(named: "search"))
        
        
    }
    

}
