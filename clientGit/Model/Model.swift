//
//  Model.swift
//  clientGit
//
//  Created by Aleksei Kokorin on 07.11.2021.
//

import UIKit


enum AuthResponce{
    case success, noVerify, error
}

struct LoginFeald{
    var email: String
    var password: String
}

struct ResponceCode{
    var code: Int
}
