//
//  TaskViewController.swift
//  TimePlannerApp
//
//  Created by Mazurov, Aleksandr on 2/23/20.
//  Copyright © 2020 AlexandrMazurov. All rights reserved.
//

import RxSwift
import RxCocoa

class TasksViewController: BaseViewController {

    private enum Constants {
        static let taskCellHeight: CGFloat = 150
    }

    @IBOutlet private weak var tasksTableView: UITableView!

    private var tasksViewModel: TasksViewModel? {
        return viewModel as? TasksViewModel
    }

    override func createObservers() {
        super.createObservers()

        guard let viewModel = tasksViewModel
        else {
            return
        }

        tasksTableView
            .rx
            .setDelegate(self)
            .disposed(by: rxBag)

        tasksTableView
            .register(UINib(nibName: TaskCell.reuseIdentifier, bundle: Bundle.main),
                      forCellReuseIdentifier: TaskCell.reuseIdentifier)

        viewModel.tasksViewData
            .bind(to: tasksTableView
                .rx
                .items(cellIdentifier: TaskCell.reuseIdentifier,
                       cellType: TaskCell.self)) { row, task, cell in
                        cell.selectionStyle = .none
                        cell.configure(with: task)
                        cell.userChangedPerformType
                            .asDriver(onErrorJustReturn: false)
                            .drive(onNext: { [weak self] _ in
                                viewModel.changePerformedViewType(at: row)
                                self?.tasksTableView.reloadData()
                            }).disposed(by: cell.rxBag)
            }
        .disposed(by: rxBag)
    }
}

extension TasksViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.taskCellHeight
    }
}
