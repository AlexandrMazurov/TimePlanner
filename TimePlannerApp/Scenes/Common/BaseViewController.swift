//
//  BaseViewController.swift
//  TimePlannerApp
//
//  Created by Mazurov, Aleksandr on 2/22/20.
//  Copyright © 2020 AlexandrMazurov. All rights reserved.
//

import RxSwift

protocol Storyboarded {
    static func instantiate() -> Self
}

class BaseViewController: UIViewController, Storyboarded {

    private(set) var rxBag = DisposeBag()
    private(set) var viewModel: BaseViewModel?
    private(set) weak var coordinator: CoordinatorProtocol?
    
    func configure(baseVM: BaseViewModel?, coordinator: CoordinatorProtocol) {
        self.viewModel = baseVM
        self.coordinator = coordinator
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createObservers()
    }
    
    internal func createObservers() {}
    
}

extension Storyboarded {

    static func instantiate() -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: AppConstants.storyboardName, bundle: Bundle.main)
        return storyboard.instantiateViewController(identifier: id) as! Self
    }
}
