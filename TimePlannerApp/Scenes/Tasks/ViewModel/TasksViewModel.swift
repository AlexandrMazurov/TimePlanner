//
//  TasksViewModel.swift
//  TimePlannerApp
//
//  Created by Mazurov, Aleksandr on 4/12/20.
//  Copyright © 2020 AlexandrMazurov. All rights reserved.
//

import RxSwift
import RxCocoa

class TasksViewModel: BaseViewModel {

    weak var repository: RepositoryProtocol?
    let tasks = BehaviorRelay<[Task]>(value: [])

    init(repository: RepositoryProtocol?) {
        self.repository = repository
    }

    override func setup() {
        super.setup()
        setupTasksModels()
    }

    override func createObservers() {
        
    }
    
    private func setupTasksModels() {
        guard let allTasks = repository?.getAllTasks() else {
            return
        }
        tasks.accept(allTasks)
    }
}
