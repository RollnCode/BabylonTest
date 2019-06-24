//
//  BTUserService.swift
//  BabylonTest
//
//  Created by Vitalii Yevtushenko on 6/19/19.
//  Copyright © 2019 Vitalii Yevtushenko. All rights reserved.
//

import Foundation
import RxSwift

final class BTUsersService: UsersService {
    
    let networking: NetworkingService
    let localStorage: LocalStorageService
    
    init(networking: NetworkingService, localStorage: LocalStorageService) {
        self.networking = networking
        self.localStorage = localStorage
    }
    
    func getAuthorForPost(_ post: Post) -> Observable<User?> {
        // Get initial data set from the database.
        let localUser = localStorage.userWithID(post.userId).take(1)
        
        // Request an updated data from the backend and save locally for further usage.
        let networkUser = networking.getUserWithID(post.userId).do(onNext: { try self.localStorage.save(users: $0) })
        
        // Combine both together.
        return Observable.merge(localUser, networkUser).map({ $0.first }).distinctUntilChanged()
    }
}
