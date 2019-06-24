//
//  ViewModel.swift
//  BabylonTest
//
//  Created by Vitalii Yevtushenko on 6/14/19.
//  Copyright © 2019 Vitalii Yevtushenko. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ViewModel {

    let services: Services
    let disposeBag: DisposeBag
    var errorsRelay: BehaviorRelay<Error?>
    
    init(services: Services) {
        disposeBag = DisposeBag()
        errorsRelay = BehaviorRelay(value: nil)
        self.services = services
    }
}
