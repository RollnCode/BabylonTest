//
//  NetworkingService.swift
//  BabylonTest
//
//  Created by Vitalii Yevtushenko on 6/14/19.
//  Copyright © 2019 Vitalii Yevtushenko. All rights reserved.
//

import Foundation
import RxSwift

public protocol NetworkingService {
    func getPosts() -> Observable<[Post]>
    func getUserWithID(_ identifier: Int) -> Observable<[User]>
    func getCommentsForPostWithID(_ identifier: Int) -> Observable<[Comment]>
}
