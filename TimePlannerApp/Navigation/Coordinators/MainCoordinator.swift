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
        navigationController.pushViewController(vc, animated: false)
    }
    
    
}
