//
//  MainCoordinator.swift
//  TimePlannerApp
//
//  Created by Mazurov, Aleksandr on 2/22/20.
//  Copyright © 2020 AlexandrMazurov. All rights reserved.
//

import UIKit

class MainCoordinator: CoordinatorProtocol {
    
    var childsCoordinators = [CoordinatorProtocol?]()
    var rootViewController: UIViewController
    private(set) weak var registry: DependencyRegistryProtocol!
    
    
    init(navigationController: UIViewController, registry: DependencyRegistryProtocol) {
        self.rootViewController = navigationController
        self.registry = registry
    }
    
    func start() {}
    
    func navigateToMainFlow() {
        guard let child = registry.makeMainFlowCoordinator(rootViewController: rootViewController) as? MainFlowCoordinator else {
            return
        }
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
