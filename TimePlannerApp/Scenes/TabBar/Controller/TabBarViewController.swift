//
//  TabBarViewController.swift
//  TimePlannerApp
//
//  Created by Mazurov, Aleksandr on 2/23/20.
//  Copyright © 2020 AlexandrMazurov. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController, Storyboarded {

    override func viewDidLoad() {
        super.viewDidLoad()
        //TODO: Provide DI
        
        setupViewControllers(
            currentTask: TasksViewController.instantiate(),
            completeTask: TasksViewController.instantiate(),
            feautureTask: TasksViewController.instantiate(),
            statistics: StatisticsViewController.instantiate(),
            settings: SettingsViewController.instantiate())
        
    }
    
    
    func setupViewControllers(currentTask currentTaskViewController: TasksViewController,
                              completeTask completeTaskViewController: TasksViewController,
                              feautureTask featutureTaskViewController: TasksViewController,
                              statistics statisticsViewController: StatisticsViewController,
                              settings settingsViewController: SettingsViewController) {
        let currentTask = wrapController(currentTaskViewController,
                                      title: "Current",
                                      image: nil)
        let completeTask = wrapController(completeTaskViewController,
                                     title: "Complete",
                                     image: nil)
        let feautureTask = wrapController(featutureTaskViewController,
                                     title: "Featuture",
                                     image: nil)
        let statistics = wrapController(statisticsViewController,
                                     title: "Statistics",
                                     image: nil)
        let settings = wrapController(settingsViewController,
                                      title: "Settings",
                                      image: nil)
        
        viewControllers = [currentTask, completeTask, feautureTask, statistics, settings]
    }
    
    private func wrapController(_ controller: UIViewController,
                                title: String,
                                image: UIImage? = nil,
                                selectedImage: UIImage? = nil) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: controller)
        navigationController.tabBarItem = UITabBarItem(title: title, image: image, selectedImage: selectedImage)
        return navigationController
    }
}
