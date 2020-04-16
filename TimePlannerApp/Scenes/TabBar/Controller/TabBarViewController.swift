//
//  TabBarViewController.swift
//  TimePlannerApp
//
//  Created by Mazurov, Aleksandr on 2/23/20.
//  Copyright © 2020 AlexandrMazurov. All rights reserved.
//

import UIKit

class TabBarViewController: BaseTabBarController {
    
    private var tabBarViewModel: TabBarViewModel? {
        return viewModel as? TabBarViewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    func setupViewControllers(dashboard dashboardViewController: DashboardViewController?,
                              tasks tasksViewController: TasksViewController?,
                              statistics statisticsViewController: StatisticsViewController?,
                              settings settingsViewController: SettingsViewController?) {
        let progress = wrapController(dashboardViewController,
                                      title: "Dashboard",
                                      image: nil)
        let tasks = wrapController(tasksViewController,
                                     title: "Tasks",
                                     image: nil)
        let statistics = wrapController(statisticsViewController,
                                     title: "Statistics",
                                     image: nil)
        let settings = wrapController(settingsViewController,
                                      title: "Settings",
                                      image: nil)
        
        viewControllers = [progress, tasks, statistics, settings]
    }
    
    private func wrapController(_ controller: UIViewController?,
                                title: String,
                                image: UIImage? = nil,
                                selectedImage: UIImage? = nil) -> UINavigationController {
        guard let controller = controller else {
            return UINavigationController()
        }
        let navigationController = UINavigationController(rootViewController: controller)
        navigationController.tabBarItem = UITabBarItem(title: title, image: image, selectedImage: selectedImage)
        return navigationController
    }
}
