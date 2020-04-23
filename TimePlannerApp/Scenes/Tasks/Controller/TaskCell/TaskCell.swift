//
//  TaskCell.swift
//  TimePlannerApp
//
//  Created by Mazurov, Aleksandr on 4/18/20.
//  Copyright © 2020 AlexandrMazurov. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell, ReusableView {

    @IBOutlet private weak var priorityView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var notificationLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!

    func configure(with task: TaskViewData) {
        descriptionLabel.numberOfLines = .max

        titleLabel.text = task.title
        descriptionLabel.text = task.description
        priorityView.backgroundColor = .green

        switch task.type {
        case .completed(let rating):
            notificationLabel.text = "Completed"
            timeLabel.text = String(describing: rating)
        case .performed(let timeBeforeEnding):
            notificationLabel.text = "Before ending:"
            timeLabel.text = timeBeforeEnding
        case .awaitingCompletion(let timeBeforeStarting):
            notificationLabel.text = "Before starting:"
            timeLabel.text = timeBeforeStarting
        case .none:
            print("None")
        }
    }
}
