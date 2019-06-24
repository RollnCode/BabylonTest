//
//  SceneCoordinator.swift
//  BabylonTest
//
//  Created by Vitalii Yevtushenko on 6/13/19.
//  Copyright © 2019 Vitalii Yevtushenko. All rights reserved.
//

import UIKit
import RxSwift

public protocol SceneCoordinator {
    @discardableResult
    func transition(to scene: SceneType, type: SceneTransitionType, animated: Bool) -> Observable<Void>
    
    @discardableResult
    func pop(animated: Bool) -> Observable<Void>
}
