//
//  MainCoordinator.swift
//  TimePlannerApp
//
//  Created by Mazurov, Aleksandr on 2/22/20.
//  Copyright © 2020 AlexandrMazurov. All rights reserved.
//

import UIKit

class MainCoordinator: CoordinatorProtocol {
    
    var childsCoordinators = [CoordinatorProtocol]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = LaunchViewController.instantiate()
        vc.configure(baseVM: LaunchViewModel(), coordinator: self)
        navigationController.pushViewController(vc, animated: false)
    }
    
    func navigateToMainFlow() {
        let child = MainFlowCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        childsCoordinators.append(child)
        child.start()
    }
    
    func childDidFinish(_ child: CoordinatorProtocol?) {
        for (index, coordinator) in childsCoordinators.enumerated() {
            if coordinator === child {
                childsCoordinators.remove(at: index)
                break
            }
        }
    }
    
    
}
