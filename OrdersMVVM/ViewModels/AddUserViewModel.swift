//
//  AddUserViewModel.swift
//  OrdersMVVM
//
//  Created by JoLi on 2016-08-27.
//  Copyright © 2016 JoLi. All rights reserved.
//

import Foundation
import RealmSwift

struct AddUserViewModel {
    private let minCharacterLenght = 5
    
    init(){}
    
    
    func createUser(withName name: String, phone: String) {
        APIManager.addUser(withName: name, phone: phone) { (user, error) in
            if let user = user {
                StorageManager.save([user])
            }
        
            if let error = error {
                print(error)
            }
        }
    }

    
    func validate(input input: String?) -> (isValid: Bool, text: String) {
        if let userInput = input where userInput.characters.count >= minCharacterLenght {
            return (true, userInput)
        } else {
            return (false, "")
        }
    }
}