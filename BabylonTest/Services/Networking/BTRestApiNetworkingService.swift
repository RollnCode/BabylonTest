//
//  BTRestApiNetworkingService.swift
//  BabylonTest
//
//  Created by Vitalii Yevtushenko on 6/14/19.
//  Copyright © 2019 Vitalii Yevtushenko. All rights reserved.
//

import Foundation
import RxSwift
import Moya

public final class BTRestApiNetworkingService: NetworkingService {
    
    private let provider: MoyaProvider<BTApiProvider>
    
    init(
        endpointClosure: @escaping (BTApiProvider) -> Endpoint = MoyaProvider<BTApiProvider>.defaultEndpointMapping,
        stubClosure: @escaping MoyaProvider<BTApiProvider>.StubClosure = MoyaProvider.neverStub
    ) {
        var plugins = [PluginType]()
        #if DEBUG
        let logger = NetworkLoggerPlugin(verbose: true, cURL: false)
        plugins.append(logger)
        #endif
        provider = MoyaProvider<BTApiProvider>(endpointClosure: endpointClosure, stubClosure: stubClosure, plugins: plugins)
    }
    
    public func getPosts() -> Observable<[Post]> {
        let request = BTApiProvider.getPosts
        return _request(endpoint: request)
    }
    
    public func getUserWithID(_ identifier: Int) -> Observable<[User]> {
        let request = BTApiProvider.getUserWithID(identifier)
        return _request(endpoint: request)
    }
    
    public func getCommentsForPostWithID(_ identifier: Int) -> Observable<[Comment]> {
        let request = BTApiProvider.getCommentsForPostWithID(identifier)
        return _request(endpoint: request)
    }
    
    private func _request<D: Decodable>(endpoint: BTApiProvider) -> Observable<D> {
        return provider.rx.request(endpoint).map(D.self).asObservable()
    }
}
