//
//  APIManager.swift
//  OrdersMVVM
//
//  Created by JoLi on 2016-08-21.
//  Copyright © 2016 JoLi. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class APIManager: NSObject {
    private static let baseURL = "https://inloop-contacts.appspot.com/_ah/api/"
    
    static func downloadUsers(completion: (users:[User]?, error:NSError? ) -> Void) {
        let contactsURL = "\(APIManager.baseURL)contactendpoint/v1/contact"
        Alamofire.request(.GET, contactsURL).responseObject { (response: Response<UsersResponse, NSError>) in
            switch response.result {
            case .Success(let usersResponse):
                completion(users: usersResponse.userItems, error: nil)

            case .Failure(let error):
                completion(users: nil, error: error)
            }
        }
    }
    
    // static func addUser(withName name: String, phone: String)
}