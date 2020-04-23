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

    private func setupViewData(from tasks: [Task]?) -> [TaskViewData] {
        guard let tasks = tasks else {
            return []
        }
        return tasks.compactMap {
            TaskViewData(title: $0.title ?? "",
                         description: $0.taskDescription ?? "",
                         priority: TaskPriority(rawValue: $0.priority.value ?? .zero),
                         type: resolveTaskType($0))
            }
    }

    private func resolveTaskType(_ task: Task) -> TaskViewType? {
        let now = Date()
        guard let startDate = task.startTime,
            let endDate = task.endTime else {
            return nil
        }
        if now >= startDate && now <= endDate {
            return .performed(timeBeforeEnding: format(duration: endDate - now))
        } else if startDate > now {
            return .awaitingCompletion(timeBeforeStarting: format(duration: startDate - now))
        } else {
            return .completed(rating: TaskScoreRating(rawValue: task.rating.value ?? .zero))
        }
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
