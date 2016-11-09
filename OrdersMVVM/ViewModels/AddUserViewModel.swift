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
    
    
    func createUser(withName name: String, phone: String, completion:@escaping (_ error: Error?) -> Void) {
        APIManager.addUser(name: name, phone: phone) { (user, error) in
            guard error == nil else {
                completion(error)
                return
            }
            
            guard let user = user else {
                completion(nil)
                return
            }
        
            StorageManager.save([user], completion: {
                completion(nil)
            })
        }
    }
    
    
    func validate(input: String?) -> (isValid: Bool, text: String) {
        if let userInput = input, userInput.characters.count >= minCharacterLenght {
            return (true, userInput)
        } else {
            return (false, "")
        }
    }
}
