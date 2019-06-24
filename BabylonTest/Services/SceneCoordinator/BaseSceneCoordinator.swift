//
//  BaseSceneCoordinator.swift
//  BabylonTest
//
//  Created by Vitalii Yevtushenko on 6/13/19.
//  Copyright © 2019 Vitalii Yevtushenko. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class BaseSceneCoordinator: SceneCoordinator {
    
    private var window: UIWindow
    
    required init(window: UIWindow) {
        self.window = window
    }
    
    // MARK: - SceneCoordinator
    
    @discardableResult
    func transition(to scene: SceneType, type: SceneTransitionType, animated: Bool) -> Observable<Void> {
        return Observable<Void>.create({ [weak self] (observer) -> Disposable in
            guard let _self = self else { return Disposables.create() }
            
            let viewController = scene.viewController()
            do {
                switch type {
                case .root:
                    viewController.view.frame = UIScreen.main.bounds
                    _self.window.rootViewController = viewController
                    observer.onCompleted()
                    
                case .push:
                    let current = try _self.currentViewController()
                    guard let navigationController = current.navigationController else {
                        throw BaseSceneCoordinatorError.emptyNavigationController
                    }
                    _ = navigationController.rx.delegate
                        .sentMessage(#selector(UINavigationControllerDelegate.navigationController(_:didShow:animated:)))
                        .map { _ in }
                        .bind(to: observer)
                    navigationController.pushViewController(viewController, animated: animated)
                    
                case .present:
                    try _self.currentViewController().present(viewController, animated: animated) {
                        observer.onCompleted()
                    }
                }
                
            } catch let error as BaseSceneCoordinatorError {
                observer.onError(ServiceError.sceneCoordinator(error))
            } catch {
                observer.onError(error)
            }
            
            return Disposables.create()
        })
        
    }
    
    @discardableResult
    func pop(animated: Bool) -> Observable<Void> {
        return Observable<Void>.create({ [weak self] (observer) -> Disposable in
            guard let _self = self else { return Disposables.create() }
            
            do {
                let current = try _self.currentViewController()
                if current.presentingViewController != nil {
                    current.dismiss(animated: animated) {
                        observer.onCompleted()
                    }
                } else if let navigationController = current.navigationController {
                    _ = navigationController.rx.delegate
                        .sentMessage(#selector(UINavigationControllerDelegate.navigationController(_:didShow:animated:)))
                        .map { _ in }
                        .bind(to: observer)
                    guard navigationController.popViewController(animated: animated) != nil else {
                        throw BaseSceneCoordinatorError.canNotToPop
                    }
                } else {
                    throw BaseSceneCoordinatorError.canNotToPop
                }
            } catch let error as BaseSceneCoordinatorError {
                observer.onError(ServiceError.sceneCoordinator(error))
            } catch {
                observer.onError(error)
            }
            
            return Disposables.create()
        })
    }
    
    // MARK: - Private
    
    private func currentViewController() throws -> UIViewController {
        guard var current = window.rootViewController else {
            throw BaseSceneCoordinatorError.emptyViewController
        }
        current = try self.actualViewController(for: current)
        
        if let presented = current.presentedViewController, !(presented is UISearchController) {
            current = try actualViewController(for: presented)
        }
        
        return current
    }
    
    private func actualViewController(for viewController: UIViewController) throws -> UIViewController {
        if let navigationController = viewController as? UINavigationController {
            guard let top = navigationController.topViewController else {
                throw BaseSceneCoordinatorError.emptyViewController
            }
            return top
        } else {
            return viewController
        }
    }
}

