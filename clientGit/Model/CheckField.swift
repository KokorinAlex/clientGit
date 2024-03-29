//
//  CheckField.swift
//  clientGit
//
//  Created by Aleksei Kokorin on 07.11.2021.
//

import UIKit

class CheckField{
    
    static let shared = CheckField()
    init() { }
    
    //isValid
    private func isValid(_ type: String, _ data: String) -> Bool{
        var dataRegEx = ""
        switch type {
        case "e":
            dataRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        default:
            dataRegEx = "(?=.*[A-Z0-9a-z]).{6,}"
        }
        let dataPred = NSPredicate(format:"SELF MATCHES %@", dataRegEx)
        return dataPred.evaluate(with: data)
    }
    
    //validField
    func validField(_ field: UITextField) -> Bool{
        let id = field.restorationIdentifier
        
        switch id {
        case "name":
            if field.text?.count ?? 0 < 3{
                validView(field, false)
                return false
            } else {
                validView(field, true)
                 return true
            }
        case "email":
            if isValid("e", field.text!) {
               validView(field, true)
                return true
            } else {
                validView(field, false)
                return false
            }
        case "password":
            if isValid("p", field.text!) {
                validView(field, true)
                return true
            } else {
                validView(field, false)
                return false
            }
        default:
            if field.text?.count ?? 0 < 2{
                validView(field, false)
                return false
            } else {
                validView(field, true)
                 return true
            }
        }
    }
    
    //valid view
    private func validView(_ field: UITextField, _ valid: Bool){
        if valid{
            field.backgroundColor = #colorLiteral(red: 0.9410838485, green: 0.9412415624, blue: 0.9410631061, alpha: 1)
   

        } else {
            field.backgroundColor = #colorLiteral(red: 1, green: 0.2566739321, blue: 0.3427716792, alpha: 1)
         
        }
    }
}
