//
//  ViewController.swift
//  BabylonTest
//
//  Created by Vitalii Yevtushenko on 6/14/19.
//  Copyright © 2019 Vitalii Yevtushenko. All rights reserved.
//

import UIKit
import RxSwift

class ViewController<T: ViewModel>: UIViewController {

    let viewModel: T
    let disposeBag = DisposeBag()
    
    // MARK: - UIViewController
    
    required init(viewModel: T) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        setupRx()
    }
    
    // MARK: - Setup
    
    func setupRx() {
        viewModel.errorsRelay.filter({ $0 != nil }).map({ $0! }).subscribe(onNext: { [weak self] (error) in
            guard let _self = self else { return }
            
            var title: String = ""
            var message: String? = nil
            let action: UIAlertAction? = nil
            
            switch error {
            case is ServiceError:
                let serviceError = error as! ServiceError
                title = "Service Error Occured"
                if let failureService = serviceError.failureReason {
                    message = failureService + " Service Failure\n"
                    message?.append(serviceError.recoverySuggestion ?? "")
                } else {
                    message = serviceError.recoverySuggestion
                }
                
            default:
                title = "Unknown error occurred"
                message = "Error description: \(error.localizedDescription)"
                
            }
            
            _self.showAlertWithTitle(title, message: message, action: action)
            
        }).disposed(by: disposeBag)
    }
    
    // MARK: - Error Display
    
    func showAlertWithTitle(_ title: String, message: String?, action: UIAlertAction?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        var mainAction: UIAlertAction
        if let _action = action {
            mainAction = _action
        } else {
            mainAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        }
        alert.addAction(mainAction)
        present(alert, animated: true, completion: nil)
    }
}
