//
//  BaseViewModel.swift
//  TimePlannerApp
//
//  Created by Mazurov, Aleksandr on 2/22/20.
//  Copyright © 2020 AlexandrMazurov. All rights reserved.
//

import RxSwift
import RxCocoa

public class BaseViewModel {
    let rxBag = DisposeBag()

    func setup() {
        createObservers()
    }
    func createObservers() {}
}
