//
//  UsersService.swift
//  BabylonTest
//
//  Created by Vitalii Yevtushenko on 6/19/19.
//  Copyright © 2019 Vitalii Yevtushenko. All rights reserved.
//

import Foundation
import RxSwift

protocol UsersService {
    func getAuthorForPost(_ post: Post) -> Observable<User?>
}
