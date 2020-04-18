//
//  RepositoryProtocol.swift
//  TimePlannerApp
//
//  Created by Mazurov, Aleksandr on 4/18/20.
//  Copyright © 2020 AlexandrMazurov. All rights reserved.
//

import RealmSwift

// swiftlint:disable identifier_name

protocol RepositoryProtocol: class {
    func addTask(_ task: Task)
    func updateTask(_ task: Task)
    func getTask(with id: String) -> Task?
    func getAllTasks() -> [Task]
    func deletTask(_ task: Task)
    func deleteAllTasks()
}
