//
//  LocalRepository.swift
//  TimePlannerApp
//
//  Created by Mazurov, Aleksandr on 4/18/20.
//  Copyright © 2020 AlexandrMazurov. All rights reserved.
//

import RealmSwift

class LocalRepository: RepositoryProtocol {

    func addTask(_ task: Task) {
        write(task)
    }

    func updateTask(_ task: Task) {
        write(task, shouldUpdate: true)
    }
    // swiftlint:disable identifier_name
    func getTask(with id: String) -> Task? {
        guard let tasks = realm?.objects(Task.self) else {
            return nil
        }
        return tasks.filter { $0.id == id }.first
    }

    func getAllTasks() -> [Task] {
        guard let tasks = realm?.objects(Task.self) else {
            return []
        }
        return tasks.toArray()
    }

    func deletTask(_ task: Task) {
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
