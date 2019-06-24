//
//  BTCommentsService.swift
//  BabylonTest
//
//  Created by Vitalii Yevtushenko on 6/19/19.
//  Copyright © 2019 Vitalii Yevtushenko. All rights reserved.
//

import Foundation
import RxSwift

final class BTCommentsService: CommentsService {
    
    let networking: NetworkingService
    let localStorage: LocalStorageService
    
    init(networking: NetworkingService, localStorage: LocalStorageService) {
        self.networking = networking
        self.localStorage = localStorage
    }
    
    func getCommentsForPost(_ post: Post) -> Observable<[Comment]> {
        // Get initial data set from the database.
        let localComments = localStorage.commentsForPostWithID(post.id).take(1)
        
        // Request an updated data from the backend and save locally for further usage.
        let networkComments = networking.getCommentsForPostWithID(post.id).do(onNext: { try self.localStorage.save(comments: $0) })
        
        // Combine both together.
        return Observable.merge(localComments, networkComments).distinctUntilChanged()
    }
    
}
