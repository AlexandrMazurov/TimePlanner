//
//  LocalRepository.swift
//  TimePlannerApp
//
//  Created by Mazurov, Aleksandr on 4/18/20.
//  Copyright © 2020 AlexandrMazurov. All rights reserved.
//

import RealmSwift
import RxCocoa
import RxSwift
import RxRealm

class LocalRepository: RepositoryProtocol {

    let tasks = BehaviorRelay<[Task]?>(value: nil)
    private let rxBag = DisposeBag()

    init() {
        createObservers()
    }

    private func createObservers() {
        guard let tasks = realm?.objects(Task.self) else {
            return
        }

        Observable
            .array(from: tasks)
            .bind(to: self.tasks)
            .disposed(by: rxBag)
    }

    func addTask(_ task: Task) {
        write(task)
    }

    func updateTask(_ task: Task) {
        write(task, shouldUpdate: true)
    }

    func deleteTask(_ task: Task) {
        delete(task)
    }

    func deleteAllTasks() {
        deleteAll()
    }
}

extension LocalRepository {

    var realm: Realm? {
        guard let realm = try? Realm()
            else { return nil }
        return realm
    }

    private func deleteAll() {
        do {
            try realm?.write {
                realm?.deleteAll()
            }
        } catch {
            print(error)
        }
    }

    private func delete<T: Object>(_ objects: Results<T>) {
        do {
            try realm?.write {
                realm?.delete(objects)
            }
        } catch {
            print(error)
        }
    }

    private func delete<T: Object>(_ object: T) {
        do {
            try realm?.write {
                realm?.delete(object)
            }
        } catch {
            print(error)
        }
    }

    private func write(_ data: Object, shouldUpdate: Bool = false, change: (() -> Void)? = nil) {
        do {
            let realm = try Realm()
            let writeAction = {
                change?()
                shouldUpdate ? realm.add(data, update: .all): realm.add(data)
            }
            if realm.isInWriteTransaction {
                writeAction()
            } else {
                try realm.write {
                    writeAction()
                }
            }
        } catch let error {
            print(error)
        }
    }
}

extension Results {
    func toArray() -> [Element] {
        return compactMap { $0 }
    }
}
