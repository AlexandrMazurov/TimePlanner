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
    var childsCoordinators = [CoordinatorProtocol?]()
    var navigationController: UIViewController
    private(set) var registry: DependencyRegistry!
    
    init(navigationController: UIViewController, registry: DependencyRegistry) {
        self.navigationController = navigationController
        self.registry = registry
    }
    
    func start() {
        //start with tabBar
        guard let tabBarVC = registry.container.resolve(TabBarViewController.self) else {
            return
        }
        navigationController.navigationController?.pushViewControllerWithFlipAnimation(viewController: tabBarVC)
    }
    
    func didFinishFlow() {
        guard let parentCoordinator = parentCoordinator as? MainCoordinator else {
            return
        }
        parentCoordinator.childDidFinish(self)
    }
    
    
    
}
