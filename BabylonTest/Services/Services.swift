//
//  Services.swift
//  BabylonTest
//
//  Created by Vitalii Yevtushenko on 6/13/19.
//  Copyright © 2019 Vitalii Yevtushenko. All rights reserved.
//

import Foundation
import RealmSwift

final class Services {
    
    let networking: NetworkingService
    let localStorage: LocalStorageService
    
    public let sceneCoordinator: SceneCoordinator
    public let postsService: PostsService
    public let usersService: UsersService
    public let commentsService: CommentsService
    
    required init(sceneCoordinator: SceneCoordinator) {
        self.sceneCoordinator = sceneCoordinator
        networking = BTRestApiNetworkingService()
    
        var configuration = Realm.Configuration()
        configuration.schemaVersion = RealmLocalStorageService.schemaVersions.last!
        localStorage = RealmLocalStorageService(configuration: configuration)
        
        postsService = BTPostsService(networking: networking, localStorage: localStorage)
        usersService = BTUsersService(networking: networking, localStorage: localStorage)
        commentsService = BTCommentsService(networking: networking, localStorage: localStorage)
    }
    
}
