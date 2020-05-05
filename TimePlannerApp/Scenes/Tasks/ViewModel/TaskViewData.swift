//
//  TaskViewData.swift
//  TimePlannerApp
//
//  Created by Mazurov, Aleksandr on 4/20/20.
//  Copyright © 2020 AlexandrMazurov. All rights reserved.
//

import RxSwift
import RxCocoa

public enum TaskViewType: Equatable {
    case completed(rating: TaskRating?)
    case performed(timeBeforeEnding: String, procentage: Double)
    case awaitingCompletion(timeBeforeStarting: String)
}

public enum TaskRating: Int, CaseIterable {
    case lowest
    case low
    case average
    case high
    case highest
    case notRaited
}

public enum PerformedTaskType: Int {
    case procentage
    case time
}

typealias TaskPriority = TaskRating

class TaskViewData {

    let title: String
    let description: String
    let priority: TaskPriority?
    var perfomedViewType: PerformedTaskType
    let state = BehaviorRelay<TaskViewType?>(value: nil)

    init(title: String,
         description: String,
         priority: TaskPriority?,
         performedTaskType: PerformedTaskType) {
        self.title = title
        self.description = description
        self.priority = priority
        self.perfomedViewType = performedTaskType
    }
}
