//
//  PostsService.swift
//  BabylonTest
//
//  Created by Vitalii Yevtushenko on 6/16/19.
//  Copyright © 2019 Vitalii Yevtushenko. All rights reserved.
//

import Foundation
import RxSwift

public protocol PostsService {
    func postsFeed() -> Observable<[Post]>
}
