//
//  BTApiProvider+TagretType.swift
//  BabylonTest
//
//  Created by Vitalii Yevtushenko on 6/14/19.
//  Copyright © 2019 Vitalii Yevtushenko. All rights reserved.
//

import Foundation
import Moya

extension BTApiProvider: TargetType {
    
    var baseURL: URL {
        return URL(string: BTApiProvider.environment.host)!
    }
    
    var path: String {
        switch self {
        case .getPosts:
            return "/posts"
        case .getUserWithID:
            return "/users"
        case .getCommentsForPostWithID:
            return "/comments"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getPosts:
            return .requestParameters(parameters: [:], encoding: URLEncoding.default)
            
        case .getUserWithID(let identifier):
            let parametrs: [String: Any] = [
                "id": identifier
            ]
            return .requestParameters(parameters: parametrs, encoding: URLEncoding.default)
            
        case .getCommentsForPostWithID(let identifier):
            let parametrs: [String: Any] = [
                "postId": identifier
            ]
            return .requestParameters(parameters: parametrs, encoding: URLEncoding.default)
        }
        
    }
    
    var headers: [String : String]? {
        return BTApiProvider.environment.headers
    }
    
    var validationType: ValidationType {
        return ValidationType.successCodes
    }
}
