//
//  Utilities.swift
//  LoginEmail
//
//  Created by Van on 12/16/19.
//  Copyright © 2019 Van. All rights reserved.
//

import Foundation
import UIKit
class Utilities{
    static func styleTextField(_ textField:UITextField){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: textField.frame.height - 2, width: textField.frame.width, height: 1)
        bottomLine.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        textField.borderStyle = .none
        textField.layer.addSublayer(bottomLine)
        
    }
    static func styleFilledButton(_ button:UIButton){
        button.backgroundColor = UIColor.init(red: 48/255, green: 173/255, blue: 95/255, alpha: 1)
        button.layer.cornerRadius = 25
        button.tintColor = UIColor.white
        
    }
    static func styleHollowButton(_ button:UIButton){
        button.layer.borderWidth = 2
        button.layer.borderColor = #colorLiteral(red: 0.4140218794, green: 0.5733807683, blue: 0.79308635, alpha: 1)
        button.layer.cornerRadius = 25
        button.tintColor = UIColor.black

    }
    static func styleBackgroundTextField(_ textField:UITextField){
        textField.layer.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        textField.layer.cornerRadius = 20
        textField.borderStyle = .none

    }
    static func setUpSignUpButton(_ button:UIButton){
        let attributedText = NSMutableAttributedString(string: "Don't have an account ?", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18), NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)])
        let attributedSubText = NSMutableAttributedString(string: "Create now", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)])
        attributedText.append(attributedSubText)
        button.setAttributedTitle(attributedText, for: UIControl.State.normal)
    }
    static func isPasswordValid(_ password:String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
        
    }
    
}
