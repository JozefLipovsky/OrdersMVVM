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
    
    static func downloadUsers(completion: @escaping ([User]?, Error? ) -> Void) {
        let contactsURL = "\(APIManager.baseURL)contactendpoint/v1/contact"
        
        Alamofire.request(contactsURL).responseObject { (response: DataResponse<UsersResponse>) in
            switch response.result {
            case .success(let userResponse):
                completion(userResponse.userItems, nil)
                
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    
    static func addUser(name: String, phone: String, completion:@escaping (User?, Error?) -> Void) {
        let contactsURL = "\(APIManager.baseURL)contactendpoint/v1/contact"
        let parameters = ["name" : name, "phone" : phone]
        
        Alamofire.request(contactsURL, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseObject { (response: DataResponse<User>) in
            switch response.result {
            case .success(let user):
                completion(user, nil)
                
            case .failure(let error):
                completion(nil,error)
            }
        }
    }

    
    static func downloadOrders(forUser userID: String, completion: @escaping ([Order]?, Error?) -> Void) {
        let ordersURL = "\(APIManager.baseURL)orderendpoint/v1/order/" + userID
        
        Alamofire.request(ordersURL).responseObject { (response: DataResponse<OrdersResponse>) in
            switch response.result {
            case .success(let ordersResponse):
                completion(ordersResponse.orderItems, nil)
                
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
