//
//  ViewModelDataState.swift
//  OrdersMVVM
//
//  Created by JoLi on 2016-10-29.
//  Copyright © 2016 JoLi. All rights reserved.
//

import Foundation


enum ViewModelDataState {
    case empty
    case available
    case error(Error)
}
