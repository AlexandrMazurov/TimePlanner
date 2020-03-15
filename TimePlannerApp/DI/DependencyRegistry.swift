//
//  DependencyRegistry.swift
//  TimePlannerApp
//
//  Created by Mazurov, Aleksandr on 3/15/20.
//  Copyright © 2020 AlexandrMazurov. All rights reserved.
//

import UIKit
import Swinject

protocol DependencyRegistryProtocol {
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
    }
    
    private func registerDependencies() {
        
    }
    
    private func registerViewModels() {
        container.register(LaunchViewModel.self) { _ in
            LaunchViewModel()
        }
        
        container.register(ProgressViewModel.self) { _ in
            ProgressViewModel()
        }
        
        container.register(TasksViewModel.self) { _ in
            TasksViewModel()
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
        
        container.register(ProgressViewController.self) { _ in
            ProgressViewController.instantiate(from: .main)
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
