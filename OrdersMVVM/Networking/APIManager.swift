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
    
    static func downloadUsers(completion: (users: [User]?, error: NSError? ) -> Void) {
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
    
    
    static func addUser(withName name: String, phone: String, completion:(user: User?, error: NSError?) -> Void) {
        let contactsURL = "\(APIManager.baseURL)contactendpoint/v1/contact"
        
        Alamofire.request(.POST, contactsURL, parameters: [:], encoding: .Custom({ (request, parameters) -> (NSMutableURLRequest, NSError?) in
            // name and phone need to be send within body, not as url params
            let userParameters = ["name" : name, "phone" : phone]
            let mutableRequest = request.URLRequest.copy() as! NSMutableURLRequest
            let data = try! NSJSONSerialization.dataWithJSONObject(userParameters, options: .PrettyPrinted)
            mutableRequest.HTTPBody = data
            mutableRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            return (mutableRequest, nil)
            
        })).responseObject { (response: Response<User, NSError>) in
            switch response.result {
            case .Success(let user):
                completion(user: user, error: nil)
                
            case .Failure(let error):
                completion(user: nil, error: error)
            }
        }
    }
}
