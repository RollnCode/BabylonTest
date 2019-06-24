//
//  AppDelegate.swift
//  BabylonTest
//
//  Created by Vitalii Yevtushenko on 6/13/19.
//  Copyright © 2019 Vitalii Yevtushenko. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let coordinator = BaseSceneCoordinator(window: window)
        let services = Services(sceneCoordinator: coordinator)
        self.window = window
        
        let postsViewModel = PostsViewModel(services: services)
        let postsScene = MainFlowScene.postsScreen(postsViewModel)
        let navigationModel = NavigationControllerModel(services: services, root: postsScene)
        let navigationScene = MainFlowScene.navigation(navigationModel)
        
        window.rootViewController = navigationScene.viewController()
        window.makeKeyAndVisible()
    
        return true
    }
}
