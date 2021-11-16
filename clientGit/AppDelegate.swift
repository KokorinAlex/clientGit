//
//  AppDelegate.swift
//  clientGit
//
//  Created by Aleksei Kokorin on 06.11.2021.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var userDefaults = UserDefaults.standard


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        userDefaults.set(false, forKey: "isLoggin")
        let isLogin = userDefaults.object(forKey: "isLoggin") as? Bool ?? false
        
        
        if isLogin{
            startApp()
        } else{
            startLogin()
        }
        
        
        
        return true
    }

    func startApp(){
        let startVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarViewController")
        self.window?.rootViewController = startVC
        self.window?.makeKeyAndVisible()
    }

    func startLogin(){
        let loginVS = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignInViewController")
        self.window?.rootViewController = loginVS
        self.window?.makeKeyAndVisible()
    }

}

