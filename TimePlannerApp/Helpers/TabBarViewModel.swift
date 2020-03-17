//
//  TabBarViewModel.swift
//  TimePlannerApp
//
//  Created by Mazurov, Aleksandr on 3/15/20.
//  Copyright © 2020 AlexandrMazurov. All rights reserved.
//

import RxSwift
import RxCocoa

class TabBarViewModel: BaseViewModel {
    
    private let tabBarControllers: TabBarControllersModel?
    
    init(controllers: TabBarControllersModel?) {
        self.tabBarControllers = controllers
    }
    
    func getTabBarControllers() -> TabBarControllersModel? {
        return tabBarControllers
    }
}
