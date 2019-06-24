//
//  User.swift
//  BabylonTest
//
//  Created by Vitalii Yevtushenko on 6/16/19.
//  Copyright © 2019 Vitalii Yevtushenko. All rights reserved.
//

import Foundation

public struct User: Codable, Equatable {
    var id: Int
    var name: String
    var username: String
    var email: String
    var phone: String
    var website: String
}
