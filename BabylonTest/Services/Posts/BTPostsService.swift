//
//  BTPostsService.swift
//  BabylonTest
//
//  Created by Vitalii Yevtushenko on 6/16/19.
//  Copyright © 2019 Vitalii Yevtushenko. All rights reserved.
//

import Foundation
import RxSwift

final class BTPostsService: PostsService {
    
    let networking: NetworkingService
    let localStorage: LocalStorageService
    
    init(networking: NetworkingService, localStorage: LocalStorageService) {
        self.networking = networking
        self.localStorage = localStorage
    }
    
    func postsFeed() -> Observable<[Post]> {
        // Get initial data set from the database.
        let localPosts = localStorage.postsFeed().take(1)

        // Request an updated data from the backend and save locally for further usage.
        let networkPosts = networking.getPosts().do(onNext: { try self.localStorage.save(posts: $0) })

        // Combine both together.
        return Observable.merge(localPosts, networkPosts).distinctUntilChanged()
    }
}
