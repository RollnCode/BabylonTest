//
//  BTApiProvider.swift
//  BabylonTest
//
//  Created by Vitalii Yevtushenko on 6/14/19.
//  Copyright © 2019 Vitalii Yevtushenko. All rights reserved.
//

import Foundation

enum BTApiProvider {
    
    static let environment = NetworkingEnvironment.prototyping
    
    case getPosts
    case getUserWithID(_ identifier: Int)
    case getCommentsForPostWithID(_ identifier: Int)
    
}
