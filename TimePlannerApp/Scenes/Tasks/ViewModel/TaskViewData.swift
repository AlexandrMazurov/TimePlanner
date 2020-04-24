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

typealias TaskPriority = TaskScoreRating

class TaskViewData {

    let title: String
    let description: String
    let priority: TaskPriority?
    var type: TaskViewType?

    init(title: String,
         description: String,
         priority: TaskPriority?,
         type: TaskViewType?) {
        self.title = title
        self.description = description
        self.priority = priority
        self.type = type
    }
}
