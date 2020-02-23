//
//  MainFlowCoordinator.swift
//  TimePlannerApp
//
//  Created by Mazurov, Aleksandr on 2/23/20.
//  Copyright © 2020 AlexandrMazurov. All rights reserved.
//

import UIKit

class MainFlowCoordinator: CoordinatorProtocol {

    weak var parentCoordinator: CoordinatorProtocol?
    var childsCoordinators = [CoordinatorProtocol]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        //start with tabBar
    }
    
    func didFinishFlow() {
        guard let parentCoordinator = parentCoordinator as? MainCoordinator else {
            return
        }
        parentCoordinator.childDidFinish(self)
    }
    
    
    
}
