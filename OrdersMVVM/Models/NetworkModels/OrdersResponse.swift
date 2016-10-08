//
//  OrdersResponse.swift
//  OrdersMVVM
//
//  Created by JoLi on 2016-09-17.
//  Copyright © 2016 JoLi. All rights reserved.
//

import Foundation
import ObjectMapper

class OrdersResponse: Mappable  {
    var orderItems: [Order]?
    
    
    required convenience init?(map: Map){
        self.init()
    }
    
    
    func mapping(map: Map) {
        orderItems <- map["items"]
    }
}
