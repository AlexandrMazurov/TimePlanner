//
//  TasksViewModel.swift
//  TimePlannerApp
//
//  Created by Mazurov, Aleksandr on 4/12/20.
//  Copyright © 2020 AlexandrMazurov. All rights reserved.
//

import Foundation

class TasksViewModel: BaseViewModel {

    weak var repository: RepositoryProtocol?

    init(repository: RepositoryProtocol?) {
        self.repository = repository
    }
}
