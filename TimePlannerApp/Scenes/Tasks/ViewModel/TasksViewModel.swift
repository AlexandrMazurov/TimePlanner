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
    let tasks = BehaviorRelay<[TaskViewData]>(value: [])

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
        tasks
            .accept(allTasks
                .compactMap { TaskViewData(
                    title: $0.title ?? "",
                    description: $0.taskDescription ?? "",
                    priority: TaskPriority.high,
                    type: TaskViewType.performed(timeBeforeEnding: Date().timeWithDefaultFormat())
                    )
            })
    }
}
