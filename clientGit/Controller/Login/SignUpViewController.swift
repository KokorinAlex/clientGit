//
//  SignUpViewController.swift
//  clientGit
//
//  Created by Aleksei Kokorin on 07.11.2021.
//

import UIKit

class SignUpViewController: UIViewController {
    var checkField = CheckField.shared
    var service = Service.shared
    
    @IBOutlet weak var mainViev: UIView!
    var tapGuest: UITapGestureRecognizer?
    
    @IBOutlet weak var createLabel: UILabel!
    @IBOutlet weak var regUserFeald: UITextField!
    @IBOutlet weak var passwordFeald: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tapGuest = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        mainViev.addGestureRecognizer(tapGuest!)

    }
    @objc func endEditing() {
        self.view.endEditing(true)
    }
    @IBAction func signUpButton(_ sender: Any) {
        if checkField.validField(regUserFeald),
           checkField.validField(passwordFeald)
        {
            if passwordFeald.text == confirmPassword.text{
                
                service.createNewUser(LoginFeald(email: regUserFeald.text!, password:passwordFeald.text!)) { [weak self] code in
                    switch code.code{
                    case 0:
                        print("Произошла ошибка регистрации")
                    case 1:
                        self?.service.confirmEmail()
                        let alert = UIAlertController(title: "Excellent", message: "Account created successfully", preferredStyle: .alert)
                        let okBtn = UIAlertAction(title: "OK", style: .default, handler: {action in
                            self?.performSegue(withIdentifier: "SignInView", sender: nil)
                        })
                        alert.addAction(okBtn)
                        self?.present(alert, animated: true, completion: nil)
                    default:
                        print("Неизвестная ошибка")
                    }
                }
        } else {
                print("Пароли не совпадают")
            }
    }
}
}
