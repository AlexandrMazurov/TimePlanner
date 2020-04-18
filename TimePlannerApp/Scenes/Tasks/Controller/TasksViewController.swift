//
//  TaskViewController.swift
//  TimePlannerApp
//
//  Created by Mazurov, Aleksandr on 2/23/20.
//  Copyright © 2020 AlexandrMazurov. All rights reserved.
//

import RxSwift
import RxCocoa

class TasksViewController: BaseViewController {
    
    @IBOutlet weak var tasksTableView: UITableView!
    
    private var tasksViewModel: TasksViewModel? {
        return viewModel as? TasksViewModel
    }

    override func createObservers() {
        super.createObservers()

        guard let viewModel = tasksViewModel
        else {
            return
        }
        print(viewModel as Any)
    }

}
