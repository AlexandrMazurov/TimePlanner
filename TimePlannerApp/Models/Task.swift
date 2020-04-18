//
//  Task.swift
//  TimePlannerApp
//
//  Created by Mazurov, Aleksandr on 4/18/20.
//  Copyright © 2020 AlexandrMazurov. All rights reserved.
//

import RealmSwift

class Task: Object {
    // swiftlint:disable identifier_name
    @objc dynamic var id: String?
    @objc dynamic var title: String?
    @objc dynamic var taskDescription: String?
    @objc dynamic var startTime: Date?
    @objc dynamic var endTime: Date?

    let priority = RealmOptional<Int>()
    let rating = RealmOptional<Int>()
    let isVompleted = RealmOptional<Bool>()

    override class func primaryKey() -> String? {
        return "id"
    }
}

extension Task {
    convenience
    init(id: String,
         title: String,
         taskDescription: String,
         startTime: Date,
         endTime: Date,
         priority: Int,
         rating: Int?) {
        self.init()
        self.id = id
        self.title = title
        self.taskDescription = taskDescription
        self.startTime = startTime
        self.endTime = endTime
        self.priority.value = priority
        self.rating.value = rating
    }
}
