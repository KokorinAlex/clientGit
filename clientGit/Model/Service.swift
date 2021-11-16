//
//  Service.swift
//  clientGit
//
//  Created by Aleksei Kokorin on 07.11.2021.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore




class Service{
    static let shared = Service()
    
    init() {}
    
    
    
    func createNewUser(_ data: LoginFeald,  complition: @escaping (ResponceCode) -> ()){
        Auth.auth().createUser(withEmail: data.email, password: data.password) { result, err in
            if err == nil {
                if result != nil {
                    let userId = result?.user.uid
                    let email = data.email
                    let data: [String: Any] = ["email":email]
                    Firestore.firestore().collection("Users").document(userId!).setData(data)
                    complition(ResponceCode(code: 1))
                }
            } else {
                complition(ResponceCode(code: 0))
                
            }
        }
    }
    
    func confirmEmail(){
        Auth.auth().currentUser?.sendEmailVerification(completion: { err in
            if err != nil {
                print(err!.localizedDescription)
            }
            })
    }
    
    func authInApp(_ data: LoginFeald, complection: @escaping (AuthResponce) -> ()){
        Auth.auth().signIn(withEmail: data.email, password: data.password) { result, err in
            if err != nil {
                complection(.error)
            } else {
                if let result = result{
                    if result.user.isEmailVerified{
                        complection(.success)
                    } else {
                        self.confirmEmail()
                        complection(.noVerify)
                    }
            }
        }
    }
}
}


