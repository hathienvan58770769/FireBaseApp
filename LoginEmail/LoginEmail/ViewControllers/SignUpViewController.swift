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
import FirebaseStorage
import FirebaseDatabase
class SignUpViewController: UIViewController {
    @IBOutlet weak var avatar: UIImageView!
    @IBAction func BackButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBOutlet weak var FirstNameTextField: UITextField!
    @IBOutlet weak var LastNameTextField: UITextField!
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var SignUpButton: UIButton!
    @IBOutlet weak var ErrorLabel: UILabel!
    var image: UIImage? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        setUpAvatar()
    }
    func setUpAvatar(){
        avatar.layer.cornerRadius = 40
        avatar.clipsToBounds = true
        avatar.isUserInteractionEnabled = true
        let tabGestur = UITapGestureRecognizer(target: self, action: #selector(presentPicker))
        avatar.addGestureRecognizer(tabGestur)
    }
    @objc func presentPicker(){
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    func setUpElements()  {
        ErrorLabel.alpha = 0
        Utilities.styleTextField(FirstNameTextField)
        Utilities.styleTextField(LastNameTextField)
        Utilities.styleTextField(EmailTextField)
        Utilities.styleTextField(PasswordTextField)
        FirstNameTextField.leftViewMode = .always
        FirstNameTextField.leftView = UIImageView(image: UIImage(named: "username"))
        LastNameTextField.leftViewMode = .always
        LastNameTextField.leftView = UIImageView(image: UIImage(named: "username"))
        EmailTextField.leftViewMode = .always
        EmailTextField.leftView = UIImageView(image: UIImage(named: "email"))
        PasswordTextField.leftViewMode = .always
        PasswordTextField.leftView = UIImageView(image: UIImage(named: "pasword"))
//        Utilities.styleFilledButton(SignUpButton)
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
        guard let imageSelected = self.image else {
            print("Avatar in nil")
            return
        }
        guard let ImageData = imageSelected.jpegData(compressionQuality: 0.4) else {
            return
        }
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
                if err != nil{
                    self.showError("Error creating user")
                }else{
                    var dict:Dictionary<String,Any> = [
                        "firstname": firstName,
                        "lastname": lastName,
                        "email":email,
                        "profileImage": "",
                        "uid": result!.user.uid
                    ]
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: dict) { (error) in
                        if  error != nil {
                            self.showError("Error saving User data")
                        }
                    }
                    let storageRef = Storage.storage().reference(forURL: "gs://loginemail-b62b4.appspot.com")
                    let storageProfileRef = storageRef.child("profile").child(result!.user.uid)
                    let metadata = StorageMetadata()
                    metadata.contentType = "image/jpg"
                    storageProfileRef.putData(ImageData, metadata: metadata) { (storageMetadata, err) in
                        if err != nil {
                            print(err!.localizedDescription)
                            return
                        }
                        storageProfileRef.downloadURL { (url, error) in
                            if let imageUrl = url?.absoluteString{
                                dict["profileImage"] = imageUrl
                            Database.database().reference().child("users").child(result!.user.uid).updateChildValues(dict) { (error, ref) in
                                    if error == nil {
                                        print("Done")
                                    }
                                }
                            }
                        }
                    }
                }
            }
        self.transitionToHome()
        }
    }
    func transitionToHome() {
        let tabbarVC = storyboard?.instantiateViewController(identifier: Constants.Storyboard.tabbarViewController)
        view.window?.rootViewController = tabbarVC
        view.window?.makeKeyAndVisible()
        }
    }
extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imageSelected = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            image = imageSelected
            avatar.image = imageSelected
        }
        if let imageOriginal = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            image = imageOriginal
            avatar.image = imageOriginal
        }
    picker.dismiss(animated: true, completion: nil)
    }
}
