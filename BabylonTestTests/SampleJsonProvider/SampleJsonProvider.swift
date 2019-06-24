//
//  SampleJsonProvider.swift
//  BabylonTestTests
//
//  Created by Vitalii Yevtushenko on 6/21/19.
//  Copyright © 2019 Vitalii Yevtushenko. All rights reserved.
//

import Foundation
import Moya
@testable import BabylonTest

struct SampleJsonProvider {
    static let posts: Data = """
    [{
        "id": 1,
        "userId": 2,
        "title": "title",
        "body": "body"
    }, {
        "id": 2,
        "userId": 3,
        "title": "title2",
        "body": "body2"
    }]
    """.data(using: .utf8)!
    
    static let user: Data = """
    [{
      "id": 1,
      "name": "Daniel Negreanu",
      "username": "Kid Poker",
      "email": "dn@danielnegreanu.com",
      "address": {
        "street": "Twain Ave.",
        "suite": "10789 W. Twain Ave. #200",
        "city": "Las Vegas",
        "zipcode": "NV 89135",
        "geo": {
          "lat": "-37.3159",
          "lng": "81.1496"
        }
      },
      "phone": "1-(702) 868-9003",
      "website": "http://danielnegreanu.com",
      "company": {
        "name": "Poker Royalty, LLC.",
        "catchPhrase": "Poker Royalty, LLC.",
        "bs": "poker"
      }
    }]
    """.data(using: .utf8)!
    
    static let comments: Data = """
    [{
    "postId": 1,
    "id": 1,
    "name": "Daniel Negreanu",
    "email": "dn@danielnegreanu.com",
    "body": "My super body!"
    },
    {
    "postId": 1,
    "id": 2,
    "name": "John Smith",
    "email": "js@sydney.com",
    "body": "Awesome body!"
    }]
    """.data(using: .utf8)!
}


