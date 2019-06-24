//
//  RealmModel.swift
//  BabylonTest
//
//  Created by Vitalii Yevtushenko on 6/17/19.
//  Copyright © 2019 Vitalii Yevtushenko. All rights reserved.
//

import Foundation
import RealmSwift

protocol RealmModel {
    
    associatedtype Model

    func update(from model: Model)
    func model() -> Model
}

extension RealmModel where Self: Object {
    init(model: Model) {
        self.init()
        self.update(from: model)
    }
}
