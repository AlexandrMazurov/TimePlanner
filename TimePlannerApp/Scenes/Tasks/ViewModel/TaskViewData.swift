//
//  TaskViewData.swift
//  TimePlannerApp
//
//  Created by Mazurov, Aleksandr on 4/20/20.
//  Copyright © 2020 AlexandrMazurov. All rights reserved.
//

import RxSwift
import RxCocoa

public enum TaskViewType {
    case completed(rating: TaskScoreRating?)
    case performed(timeBeforeEnding: String, procentage: Int)
    case awaitingCompletion(timeBeforeStarting: String)
}

public enum TaskScoreRating: Int {
    case none
    case lowest
    case low
    case average
    case high
    case highest
}

public enum PerformedTaskType: Int {
    case procentage
    case time
}

typealias TaskPriority = TaskScoreRating

class TaskViewData {

    let title: String
    let description: String
    let priority: TaskPriority?
    var state: TaskViewType?
    var perfomedViewType: PerformedTaskType

    init(title: String,
         description: String,
         priority: TaskPriority?,
         state: TaskViewType?,
         performedTaskType: PerformedTaskType) {
        self.title = title
        self.description = description
        self.priority = priority
        self.state = state
        self.perfomedViewType = performedTaskType
    }
}
