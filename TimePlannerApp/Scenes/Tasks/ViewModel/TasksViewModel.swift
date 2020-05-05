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

    private enum Constants {
        static let refreshTaskStateInterval: Int = 50
    }

    let tasksViewData = BehaviorRelay<[TaskViewData]>(value: [])
    weak var repository: RepositoryProtocol?

    init(repository: RepositoryProtocol?) {
        self.repository = repository
    }

    override func setup() {
        super.setup()
    }

    override func createObservers() {

        repository?.deleteAllTasks()
        for index in 1...6 {
            let task = Task(id: UUID().description,
                            title: "My Second Task",
                            taskDescription: "This is my second task",
                            startTime: Date(),
                            endTime: Calendar.current.date(byAdding: .minute,
                                                        value: index,
                                                        to: Date()) ?? Date(),
                            priority: index - 1)
            task.rating.value = index - 1
            repository?.addTask(task)
        }

        repository?.tasks
            .map({ [weak self] in
                self?.setupViewData(from: $0) ?? []
            })
            .bind(to: tasksViewData)
        .disposed(by: rxBag)

        Observable<Int>
            .interval(.milliseconds(Constants.refreshTaskStateInterval), scheduler: MainScheduler.instance)
            .map { _ in Void() }
            .bind(onNext: updateTasksState)
            .disposed(by: rxBag)
    }

    func changePerformedViewType(at row: Int) {
        let taskViewData = tasksViewData.value[row]
        let newType: PerformedTaskType = taskViewData.perfomedViewType == .time ? .procentage: .time
        taskViewData.perfomedViewType = newType
    }

    private func updateTasksState() {
        let tasks = repository?.tasks.value
        for (index, taskData) in tasksViewData.value.enumerated() {
            taskData.state.accept(resolveTaskState(tasks?[index]))
        }
    }

    private func setupViewData(from tasks: [Task]?) -> [TaskViewData] {
        guard let tasks = tasks else {
            return []
        }
        return tasks.compactMap {
            TaskViewData(title: $0.title ?? "",
                        description: $0.taskDescription ?? "",
                        priority: $0.taskPriority,
                        performedTaskType: .procentage)
        }
    }

    private func resolveTaskState(_ task: Task?) -> TaskViewType? {
        let now = Date()
        guard let task = task,
            let startTime = task.startTime,
            let endTime = task.endTime else {
            return nil
        }
        if now >= startTime && now <= endTime {
            return .performed(timeBeforeEnding: format(duration: endTime - now),
                              procentage: calculateProcentage(startTime: startTime, endTime: endTime))
        } else if startTime > now {
            return .awaitingCompletion(timeBeforeStarting: format(duration: startTime - now))
        } else {
            return .completed(rating: task.taskRating)
        }
    }

    private func calculateProcentage(startTime: Date, endTime: Date) -> Double {
        let now = Date()
        return  100 * (now - startTime) / (endTime - startTime)
    }

    func format(duration: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.zeroFormattingBehavior = .pad
        if duration >= 3600 {
            formatter.allowedUnits = [.hour, .minute, .second]
        } else {
            formatter.allowedUnits = [.minute, .second]
        }
        return formatter.string(from: duration) ?? ""
    }
}
