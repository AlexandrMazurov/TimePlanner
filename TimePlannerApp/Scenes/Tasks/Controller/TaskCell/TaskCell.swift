//
//  TaskCell.swift
//  TimePlannerApp
//
//  Created by Mazurov, Aleksandr on 4/18/20.
//  Copyright © 2020 AlexandrMazurov. All rights reserved.
//

import UIKit

private enum ExecutingTaskViewType {
    case time
    case procentage
}

class TaskCell: UITableViewCell, ReusableView {

    @IBOutlet private weak var taskView: UIView!
    @IBOutlet private weak var priorityView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var notificationLabel: UILabel!
    @IBOutlet private weak var executingButton: UIButton!
    @IBOutlet private weak var descriptionLabel: UILabel!

    var didUserChangePerformedType: (() -> Void)?

    @IBAction func executingButtonTapped(_ sender: UIButton) {
        didUserChangePerformedType?()
    }

    func configure(with task: TaskViewData) {
        setupViewSettings()
        setupPriorityView(with: task.priority ?? .none)
        titleLabel.text = task.title
        descriptionLabel.text = task.description

        switch task.state {
        case .completed(let rating):
            notificationLabel.text = "Completed"
            executingButton.setTitle(String(describing: rating), for: .normal)
        case .performed(let data):
            switch task.perfomedViewType {
            case .time:
                executingButton.setTitle(data.timeBeforeEnding, for: .normal)
            case .procentage:
                executingButton.setTitle("\(data.procentage.description)%", for: .normal)
            }
            notificationLabel.text = "Before ending:"
        case .awaitingCompletion(let timeBeforeStarting):
            notificationLabel.text = "Before starting:"
            executingButton.setTitle(timeBeforeStarting, for: .normal)
        case .none:
            print("None")
        }
    }

    private func setupPriorityView(with priority: TaskPriority) {
        switch priority {
        case .none:
            priorityView.backgroundColor = .clear
        case .lowest:
            priorityView.backgroundColor = ColorName.lowestPriority.color
        case .low:
            priorityView.backgroundColor = ColorName.lowPriority.color
        case .average:
            priorityView.backgroundColor = ColorName.averagePriority.color
        case .high:
            priorityView.backgroundColor = ColorName.highPriority.color
        case .highest:
            priorityView.backgroundColor = ColorName.highestPriority.color
        }
    }

    private func setupViewSettings() {
        priorityView.layer.cornerRadius = priorityView.frame.size.height / 2
        descriptionLabel.numberOfLines = .max
        taskView.layer.shadowColor = UIColor.lightGray.cgColor
        taskView.layer.shadowOpacity = 1
        taskView.layer.shadowOffset = .zero
        taskView.layer.shadowRadius = 3
        taskView.layer.cornerRadius = 10
    }
}
