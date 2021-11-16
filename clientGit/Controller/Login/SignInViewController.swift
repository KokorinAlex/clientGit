//
//  SignInViewController.swift
//  clientGit
//
//  Created by Aleksei Kokorin on 07.11.2021.
//

import UIKit


class SignInViewController: UIViewController {
    
    @IBOutlet private weak var welcomeLabel: UILabel!
    @IBOutlet private weak var nameFeald: UITextField!
    @IBOutlet private weak var emailFeald: UITextField!
    @IBOutlet private weak var passwordFeald: UITextField!
    @IBOutlet private weak var signInButton: UIButton!
    @IBOutlet private weak var forgotPasswordButton: UIButton!
    @IBOutlet private weak var createAccButton: UIButton!
    var userDefaults = UserDefaults.standard
    var checkField = CheckField.shared
    var tapGuest: UITapGestureRecognizer?
    var service = Service.shared
    
    @IBOutlet weak var mainView: UIView!
    



    override func viewDidLoad() {
        super.viewDidLoad()
        tapGuest = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        mainView.addGestureRecognizer(tapGuest!)
    }
    @objc func endEditing() {
        self.view.endEditing(true)

    }
    
    
    @IBAction func signInButtonAction(_ sender: Any) {
        if checkField.validField(emailFeald),
           checkField.validField(passwordFeald){
            service.authInApp(LoginFeald(email: emailFeald.text!, password: passwordFeald.text!)) { [weak self] responce in
                switch responce {
                case .success:
                   print("next")
                    self?.userDefaults.set(true, forKey: "isLoggin")
                case .noVerify:
                    let alert = self?.alertAction("Error", "You are not verified. A link has been sent to your mail!")
                    let verefyBtn = UIAlertAction(title: "OK", style: .cancel) 
                    alert?.addAction(verefyBtn)
                    self?.present(alert!, animated: true)
                case .error:
                    let alert = self?.alertAction("Error", "The data was entered incorrectly!")
                    let verefyBtn = UIAlertAction(title: "OK", style: .cancel)
                    alert?.addAction(verefyBtn)
                    self?.present(alert!, animated: true)
                }
            }
        }
        else {
            let alert = self.alertAction("Error", "Please check your details!")
            let verefyBtn = UIAlertAction(title: "OK", style: .cancel)
            alert.addAction(verefyBtn)
            self.present(alert, animated: true)
        }
    }
    func alertAction(_ header: String?,_ messagge: String?) ->UIAlertController{
        let alert = UIAlertController(title: header, message: messagge, preferredStyle: .alert)
        return alert
    }
    
    @IBAction func forgotPasswordButtonAction(_ sender: Any) {
    }
}
