//
//  SwinjectStoryboard+Setup.swift
//  TimePlannerApp
//
//  Created by Mazurov, Aleksandr on 3/15/20.
//  Copyright © 2020 AlexandrMazurov. All rights reserved.
//
import UIKit

//DI
import Swinject
import SwinjectStoryboard

//ReactiveX
import RxSwift
import RxCocoa

extension SwinjectStoryboard {
    
    @objc class func setup() {
        if SceneDelegate.dependencyRegistry == nil {
            SceneDelegate.dependencyRegistry = DependencyRegistry(container: defaultContainer)
        }
        
        let dependencyRegistry: DependencyRegistryProtocol = SceneDelegate.dependencyRegistry
        
        func main() {
            dependencyRegistry.container.storyboardInitCompleted(LaunchViewController.self) { (reg, controller) in
                let coordinator = dependencyRegistry.makeMainCoordinator(rootViewController: controller)
                setupData(resolver: reg, navigationCoordinator: coordinator)
                controller.configure(baseVM: reg.resolve(LaunchViewModel.self), coordinator: coordinator)
            }
            
            dependencyRegistry.container.storyboardInitCompleted(ProgressViewController.self) { (reg, controller) in
                let coordinator = dependencyRegistry.makeMainFlowCoordinator(rootViewController: controller)
                controller.configure(baseVM: reg.resolve(ProgressViewModel.self), coordinator: coordinator)
            }
            
            dependencyRegistry.container.storyboardInitCompleted(TasksViewController.self) { (reg, controller) in
                let coordinator = dependencyRegistry.makeMainFlowCoordinator(rootViewController: controller)
                controller.configure(baseVM: reg.resolve(TasksViewModel.self), coordinator: coordinator)
            }
            
            dependencyRegistry.container.storyboardInitCompleted(StatisticsViewController.self) { (reg, controller) in
                let coordinator = dependencyRegistry.makeMainFlowCoordinator(rootViewController: controller)
                controller.configure(baseVM: reg.resolve(StatisticsViewModel.self), coordinator: coordinator)
            }
            
            dependencyRegistry.container.storyboardInitCompleted(SettingsViewController.self) { (reg, controller) in
                let coordinator = dependencyRegistry.makeMainFlowCoordinator(rootViewController: controller)
                controller.configure(baseVM: reg.resolve(SettingsViewModel.self), coordinator: coordinator)
            }
        }
        
        func setupData(resolver res: Resolver,  navigationCoordinator: CoordinatorProtocol) {
            SceneDelegate.rootCoordinator = navigationCoordinator
        }
        
        main()
    }
    

}
