//
//  NavigationControllerModel.swift
//  BabylonTest
//
//  Created by Vitalii Yevtushenko on 6/14/19.
//  Copyright © 2019 Vitalii Yevtushenko. All rights reserved.
//

import UIKit

class NavigationControllerModel: ViewModel {
    let root: MainFlowScene
    
    init(services: Services, root: MainFlowScene) {
        self.root = root
        super.init(services: services)
    }

}
