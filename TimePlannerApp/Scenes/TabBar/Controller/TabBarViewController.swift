//
//  TabBarViewController.swift
//  TimePlannerApp
//
//  Created by Mazurov, Aleksandr on 2/23/20.
//  Copyright © 2020 AlexandrMazurov. All rights reserved.
//

import UIKit

class TabBarViewController: BaseTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //TODO: Provide DI
        
        guard let viewModel = viewModel as? TabBarViewModel else {
            return
        }
        let controllers = viewModel.getTabBarControllers()
        setupViewControllers(progress: controllers?.progressViewController,
                             tasks: controllers?.tasksViewController,
                             completeTask: controllers?.completedTasksViewController,
                             statistics: controllers?.statisticsViewController,
                             settings: controllers?.settingsViewController)
        
    }
    
    
    func setupViewControllers(progress progressViewController: ProgressViewController?,
                              tasks tasksViewController: TasksViewController?,
                              completeTask completeTaskViewController: TasksViewController?,
                              statistics statisticsViewController: StatisticsViewController?,
                              settings settingsViewController: SettingsViewController?) {
        let progress = wrapController(progressViewController,
                                      title: "Progress",
                                      image: nil)
        let tasks = wrapController(tasksViewController,
                                     title: "Tasks",
                                     image: nil)
        let completeTasks = wrapController(completeTaskViewController,
                                     title: "Completed",
                                     image: nil)
        let statistics = wrapController(statisticsViewController,
                                     title: "Statistics",
                                     image: nil)
        let settings = wrapController(settingsViewController,
                                      title: "Settings",
                                      image: nil)
        
        viewControllers = [progress, tasks, completeTasks, statistics, settings]
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
