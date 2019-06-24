//
//  MainFlowScene.swift
//  BabylonTest
//
//  Created by Vitalii Yevtushenko on 6/13/19.
//  Copyright © 2019 Vitalii Yevtushenko. All rights reserved.
//

import Foundation

enum MainFlowScene: SceneType {
    case navigation(NavigationControllerModel)
    case postsScreen(PostsViewModel)
    case postDetail(PostDetailViewModel)
}
