//
//  DependencyRegistry.swift
//  TimePlannerApp
//
//  Created by Mazurov, Aleksandr on 3/15/20.
//  Copyright © 2020 AlexandrMazurov. All rights reserved.
//

import UIKit
import Swinject

protocol DependencyRegistryProtocol: AnyObject {
    var container: Container { get }
    var navigationCoordinator: CoordinatorProtocol! { get }

    func makeMainCoordinator(rootViewController: UIViewController) -> CoordinatorProtocol
    func makeMainFlowCoordinator(rootViewController: UIViewController) -> CoordinatorProtocol
}

class DependencyRegistry: DependencyRegistryProtocol {

    var container: Container
    var navigationCoordinator: CoordinatorProtocol!

    init(container: Container) {
        self.container = container
        registerDependencies()
        registerViewModels()
        registerViewControllers()
    }

    private func registerDependencies() {

        container.register(MainCoordinator.self) { (_, rootViewController: UIViewController) in
            MainCoordinator(navigationController: rootViewController, registry: self)
        }

        container.register(MainFlowCoordinator.self) { (_, rootViewController: UIViewController) in
            MainFlowCoordinator(navigationController: rootViewController, registry: self)
        }

        container.register(TabBarControllersModel.self) {
            TabBarControllersModel(dashboardViewController: $0.resolve(DashboardViewController.self),
                                   tasksViewController: $0.resolve(TasksViewController.self),
                                   statisticsViewController: $0.resolve(StatisticsViewController.self),
                                   settingsViewController: $0.resolve(SettingsViewController.self))
        }
        container.register(LocalRepository.self) { _ in
            LocalRepository()
        }.inObjectScope(.container)
    }

    private func registerViewModels() {
        container.register(TabBarViewModel.self) { _ in
            TabBarViewModel()
        }

        container.register(LaunchViewModel.self) { _ in
            LaunchViewModel()
        }

        container.register(DashboardViewModel.self) { _ in
            DashboardViewModel()
        }

        container.register(TasksViewModel.self) {
            TasksViewModel(repository: $0.resolve(LocalRepository.self))
        }

        container.register(StatisticsViewModel.self) { _ in
            StatisticsViewModel()
        }

        container.register(SettingsViewModel.self.self) { _ in
            SettingsViewModel()
        }
    }

    private func registerViewControllers() {

        container.register(TabBarViewController.self) { _ in
            TabBarViewController()
        }

        container.register(LaunchViewController.self) { _ in
            LaunchViewController.instantiate(from: .main)
        }

        container.register(DashboardViewController.self) { _ in
            DashboardViewController.instantiate(from: .main)
        }

        container.register(TasksViewController.self) { _ in
            TasksViewController.instantiate(from: .main)
        }

        container.register(StatisticsViewController.self) { _ in
            StatisticsViewController.instantiate(from: .main)
        }

        container.register(SettingsViewController.self) { _ in
            SettingsViewController.instantiate(from: .main)
        }

    }

    func makeMainCoordinator(rootViewController: UIViewController) -> CoordinatorProtocol {
        navigationCoordinator = container.resolve(MainCoordinator.self, argument: rootViewController)
        return navigationCoordinator
    }

    func makeMainFlowCoordinator(rootViewController: UIViewController) -> CoordinatorProtocol {
        navigationCoordinator = container.resolve(MainFlowCoordinator.self, argument: rootViewController)
        return navigationCoordinator
    }

}
