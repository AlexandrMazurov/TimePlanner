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
    var rootViewController: UIViewController
    private(set) var registry: DependencyRegistry!

    init(navigationController: UIViewController, registry: DependencyRegistry) {
        self.rootViewController = navigationController
        self.registry = registry
    }

    func start() {
        guard let tabBarVC = registry.container.resolve(TabBarViewController.self) else {
            return
        }
        tabBarVC.configure(baseVM: registry.container.resolve(TabBarViewModel.self), coordinator: self)
        let model = registry.container.resolve(TabBarControllersModel.self)
        tabBarVC.setupViewControllers(dashboard: model?.dashboardViewController,
                                      tasks: model?.tasksViewController,
                                      statistics: model?.statisticsViewController,
                                      settings: model?.settingsViewController)
        rootViewController.presentWithFlipAnimation(viewController: tabBarVC)
    }

    func didFinishFlow() {
        guard let parentCoordinator = parentCoordinator as? MainCoordinator else {
            return
        }
        parentCoordinator.childDidFinish(self)
    }
}
