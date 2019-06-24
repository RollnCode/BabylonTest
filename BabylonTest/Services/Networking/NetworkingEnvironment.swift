//
//  NetworkingEnvironment.swift
//  BabylonTest
//
//  Created by Vitalii Yevtushenko on 6/14/19.
//  Copyright © 2019 Vitalii Yevtushenko. All rights reserved.
//

import Foundation

struct NetworkingEnvironment {
    var host: String
    var headers: [String: String]
}

extension NetworkingEnvironment {
    static let prototyping = NetworkingEnvironment(
        host: "http://jsonplaceholder.typicode.com",
        headers: [:]
    )
}
