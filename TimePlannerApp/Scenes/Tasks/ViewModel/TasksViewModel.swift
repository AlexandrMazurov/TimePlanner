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
        static let secondTimeInterval: Int = 1
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

        repository?.addTask(Task(id: UUID().description,
                                 title: "My Second Task",
                                 taskDescription: "This is my second task",
                                 startTime: Date(),
                                 endTime: Calendar.current.date(byAdding: .minute, value: 1, to: Date()) ?? Date(),
                                 priority: 1))

        repository?.tasks
            .map({ [weak self] in
                self?.setupViewData(from: $0) ?? []
            })
            .bind(to: tasksViewData)
        .disposed(by: rxBag)

        Observable<Int>
            .interval(.seconds(Constants.secondTimeInterval), scheduler: MainScheduler.instance)
            .flatMap({ [weak self] _ in Observable.just(self?.repository?.tasks) })
            .map({ [weak self] in (self?.setupViewData(from: $0?.value) ?? []) })
            .bind(to: tasksViewData)
            .disposed(by: rxBag)
    }

    func changePerformedViewType(at row: Int) {
        guard let task = repository?.tasks.value?[row],
            let type = task.performedTaskType else {
            return
        }
        let newType: PerformedTaskType = type == .time ? .procentage: .time
        repository?.updateTask(task, change: {
            task.performedTaskType = newType
        })
    }

    private func setupViewData(from tasks: [Task]?) -> [TaskViewData] {
        guard let tasks = tasks else {
            return []
        }
        return tasks.compactMap {
            TaskViewData(title: $0.title ?? "",
                         description: $0.taskDescription ?? "",
                         priority: $0.taskPriority,
                         state: resolveTaskState($0),
                         performedTaskType: $0.performedTaskType ?? .procentage)
            }
    }

    private func resolveTaskState(_ task: Task) -> TaskViewType? {
        let now = Date()
        guard let startTime = task.startTime,
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

    private func calculateProcentage(startTime: Date, endTime: Date) -> Int {
        let now = Date()
        return Int( 100 * (now - startTime) / (endTime - startTime) )
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
