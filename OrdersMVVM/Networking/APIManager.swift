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
    
    
    
    static func addUser(withName name: String, phone: String, completion:@escaping (User?, Error?) -> Void) {
        let contactsURL = "\(APIManager.baseURL)contactendpoint/v1/contact"
        let parameters = ["name" : name, "phone" : phone]
        
        Alamofire.request(contactsURL, method: .post, parameters: parameters, encoding: URLEncoding.httpBody).responseObject { (response: DataResponse<User>) in
            switch response.result {
            case .success(let user):
                completion(user, nil)
                
            case .failure(let error):
                completion(nil,error)
            }
        }
    }

    
    
//    static func addUser(withName name: String, phone: String, completion:(_ user: User?, _ error: Error?) -> Void) {
//        let contactsURL = "\(APIManager.baseURL)contactendpoint/v1/contact"
//        
//        Alamofire.request(.POST, contactsURL, parameters: [:], encoding: .Custom({ (request, parameters) -> (NSMutableURLRequest, NSError?) in
//            // name and phone need to be send within body, not as url params
//            let userParameters = ["name" : name, "phone" : phone]
//            let mutableRequest = request.URLRequest.copy() as! NSMutableURLRequest
//            let data = try! NSJSONSerialization.dataWithJSONObject(userParameters, options: .PrettyPrinted)
//            mutableRequest.HTTPBody = data
//            mutableRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
//            return (mutableRequest, nil)
//            
//        })).responseObject { (response: Response<User, NSError>) in
//            switch response.result {
//            case .Success(let user):
//                completion(user: user, error: nil)
//                
//            case .Failure(let error):
//                completion(user: nil, error: error)
//            }
//        }
//    }
    
    
    static func downloadOrders(forUserID id: String, completion: @escaping ([Order]?, Error?) -> Void) {
        let ordersURL = "\(APIManager.baseURL)orderendpoint/v1/order/" + id
        
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
