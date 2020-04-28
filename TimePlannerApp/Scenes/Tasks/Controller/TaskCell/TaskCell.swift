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
    @IBOutlet private weak var progressView: ProgressView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var progressButton: UIButton!

    var didUserChangePerformedType: (() -> Void)?

    @IBAction func porgressButtonTapped(_ sender: UIButton) {
        self.didUserChangePerformedType?()
    }

    func configure(with task: TaskViewData) {
        setupViewSettings()
        setupPriorityView(with: task.priority ?? .none)
        progressView.layoutIfNeeded()
        titleLabel.text = task.title
        descriptionLabel.text = task.description
        configureViewState(with: task)
    }

    private func configureViewState(with task: TaskViewData) {
        switch task.state {
        case .completed(let rating):
            notificationLabel.text = "Completed"
            progressView.setupInfo(with: "Completed", description: "")
            print(rating as Any)
        case .performed(let data):
            switch task.perfomedViewType {
            case .time:
                progressView.setupInfo(with: data.timeBeforeEnding, description: "Befor ending")
            case .procentage:
                progressView.setupInfo(with: "\(Int(data.procentage).description)%", description: "completed")
            }
            progressView.confogureProgressView(duration: 1,
                                           fromValue: Double(data.oldProcentage / 100),
                                           toValue: Double(data.procentage / 100))
            notificationLabel.text = "Before ending:"
        case .awaitingCompletion(let timeBeforeStarting):
            notificationLabel.text = "Before starting:"
            progressView.setupInfo(with: timeBeforeStarting, description: "awaiting")
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
