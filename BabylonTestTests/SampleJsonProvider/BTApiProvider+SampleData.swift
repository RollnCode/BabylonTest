//
//  SampleJsonProvider+BTApiProvider.swift
//  BabylonTestTests
//
//  Created by Vitalii Yevtushenko on 6/21/19.
//  Copyright © 2019 Vitalii Yevtushenko. All rights reserved.
//

import Foundation
import Moya
@testable import BabylonTest

extension SampleJsonProvider {
    static func successEndpointForTarget(_ target: BTApiProvider) -> Endpoint {
        return Endpoint(
            url: URL(target: target).absoluteString,
            sampleResponseClosure: {
                .networkResponse(200, SampleJsonProvider.dataForTarget(target))
            },
            method: target.method,
            task: target.task,
            httpHeaderFields: target.headers
        )
    }
    
    static func dataForTarget(_ target: BTApiProvider) -> Data {
        switch target {
        case .getPosts:
            return SampleJsonProvider.posts
            
        case .getUserWithID:
            return SampleJsonProvider.user
            
        case .getCommentsForPostWithID:
            return SampleJsonProvider.comments
        }
    }
}
