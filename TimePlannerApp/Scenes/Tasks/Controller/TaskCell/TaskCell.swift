//
//  TaskCell.swift
//  TimePlannerApp
//
//  Created by Mazurov, Aleksandr on 4/18/20.
//  Copyright © 2020 AlexandrMazurov. All rights reserved.
//

import RxSwift
import RxCocoa

private enum ExecutingTaskViewType {
    case time
    case procentage
}

class TaskCell: UITableViewCell, ReusableView {

    @IBOutlet private weak var taskView: UIView!
    @IBOutlet private weak var priorityView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var notificationLabel: UILabel!
    @IBOutlet private weak var progressView: UIView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var infoMetricLabel: UILabel!
    @IBOutlet private weak var infoDescriptionLabel: UILabel!
    @IBOutlet private weak var progressButton: UIButton!

    var didUserChangePerformedType: (() -> Void)?
    let rxBag = DisposeBag()

    @IBAction func porgressButtonTapped(_ sender: UIButton) {
        self.didUserChangePerformedType?()
    }

    func configure(with task: TaskViewData) {
        setupObservers(with: task)
        setupViewSettings()
        setupPriorityView(with: task.priority ?? .none)
        titleLabel.text = task.title
        descriptionLabel.text = task.description
    }

    private func setupObservers(with task: TaskViewData) {
        task.state
            .subscribe { [weak self] state in
                guard let state  = state.element as? TaskViewType else {
                    return
                }
                self?.progressView.layoutIfNeeded()
                self?.configureViewState(state, performedType: task.perfomedViewType)
        }.disposed(by: rxBag)
    }

    private func configureViewState(_ state: TaskViewType, performedType: PerformedTaskType) {
        switch state {
        case .completed(let rating):
            notificationLabel.text = "Completed"
            setProgressInfo(metric: "Completed", description: "")
            print(rating as Any)
        case .performed(let data):
            switch performedType {
            case .time:
                infoMetricLabel.text = data.timeBeforeEnding
                infoDescriptionLabel.text = "Befor ending"
            case .procentage:
                setProgressInfo(metric: "\(Int(data.procentage).description)%", description: "completed")
            }
            progressView.layer.configureCircleProgress(progress: Double(data.procentage / 100),
                                                       lineWidth: 7,
                                                       color: UIColor.green.cgColor)
            notificationLabel.text = "Before ending:"
        case .awaitingCompletion(let timeBeforeStarting):
            notificationLabel.text = "Before starting:"
            setProgressInfo(metric: timeBeforeStarting, description: "awaiting")
        }
    }

    private func setProgressInfo(metric: String?, description: String?) {
        infoMetricLabel.text = metric
        infoDescriptionLabel.text = description
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
