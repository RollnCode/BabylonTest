//
//  NavigationController.swift
//  BabylonTest
//
//  Created by Vitalii Yevtushenko on 6/14/19.
//  Copyright © 2019 Vitalii Yevtushenko. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    
    var viewModel: NavigationControllerModel!
    
    init(viewModel: NavigationControllerModel) {
        self.viewModel = viewModel
        super.init(rootViewController: viewModel.root.viewController())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

}
