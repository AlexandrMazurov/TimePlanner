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
    case completed(rating: TaskScoreRating)
    case performed(time: String)
    case awaitingCompletion(timeBeforeStarting: String)
}

public enum TaskScoreRating {
    case highest
    case high
    case average
    case low
    case lowest
}

typealias TaskPriority = TaskScoreRating

class TaskViewdata {

    let title: String
    let priority: TaskPriority?
    var type: TaskViewType

    init(title: String, priority: TaskPriority?, type: TaskViewType) {
        self.title = title
        self.priority = priority
        self.type = type
    }
}
