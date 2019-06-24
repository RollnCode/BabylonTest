//
//  MainFlowScene+ViewController.swift
//  BabylonTest
//
//  Created by Vitalii Yevtushenko on 6/13/19.
//  Copyright © 2019 Vitalii Yevtushenko. All rights reserved.
//

import UIKit

extension MainFlowScene {
    func viewController() -> UIViewController {
        switch self {
        case .navigation(let viewModel):
            return NavigationController(viewModel: viewModel)
            
        case .postsScreen(let viewModel):
            return PostsViewController(viewModel: viewModel)
            
        case .postDetail(let viewModel):
            return PostDetailViewController(viewModel: viewModel)
        }
    }
}
