//
//  RepositoryProtocol.swift
//  TimePlannerApp
//
//  Created by Mazurov, Aleksandr on 4/18/20.
//  Copyright © 2020 AlexandrMazurov. All rights reserved.
//

import RealmSwift
import RxCocoa

protocol RepositoryProtocol: class {

    var tasks: BehaviorRelay<[Task]?> { get }
    func addTask(_ task: Task)
    func updateTask(_ task: Task, change: (() -> Void)?)
    func deleteTask(_ task: Task)
    func deleteAllTasks()
}
