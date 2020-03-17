//
//  BaseViewController.swift
//  TimePlannerApp
//
//  Created by Mazurov, Aleksandr on 2/22/20.
//  Copyright © 2020 AlexandrMazurov. All rights reserved.
//

import RxSwift

class BaseViewController: UIViewController {

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
