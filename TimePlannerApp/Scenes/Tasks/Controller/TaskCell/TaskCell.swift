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

private enum Constants {
    static let awaitingRatingTitle = L10n.Task.Awaiting.Rating.title
    static let completedTitle = L10n.Task.State.Completed.title
    static let beforeEndingTitle = L10n.Task.Info.Before.Ending.title
    static let beforeStartingTitle = L10n.Task.State.Before.Starting.title
    static let awaitingStateTitle = L10n.Task.State.Awaiting.title
    static let performedTitle = L10n.Task.State.Performed.title
    static let procentageDevider: Double = 100
    static let circleProgressLineWidth: CGFloat = 7
    static let halfViewSizeDevider: CGFloat = 2
    static let taskViewShadowOpacity: Float = 1
    static let taskViewShadowRadius: CGFloat = 3
    static let taskViewCornerRadius: CGFloat = 10
}

class TaskCell: UITableViewCell, ReusableView {

    @IBOutlet private weak var taskView: UIView!
    @IBOutlet private weak var priorityView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var stateLabel: UILabel!
    @IBOutlet private weak var progressView: UIView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var infoMetricLabel: UILabel!
    @IBOutlet private weak var infoDescriptionLabel: UILabel!
    @IBOutlet private weak var progressButton: UIButton!
    @IBOutlet private weak var ratingView: RatingView!
    @IBOutlet private weak var awatingRatingLabel: UILabel!

    let userChangedPerformType = PublishSubject<Bool>()
    private(set) var rxBag = DisposeBag()

    override func prepareForReuse() {
        super.prepareForReuse()
        rxBag = DisposeBag()
    }

    func configure(with task: TaskViewData) {
        setupObservers(with: task)
        setupViewSettings()
        setupPriorityView(with: task.priority ?? .notRaited)
        titleLabel.text = task.title
        descriptionLabel.text = task.description
        awatingRatingLabel.text = Constants.awaitingRatingTitle
    }

    private func setupObservers(with task: TaskViewData) {
        task.state
            .distinctUntilChanged()
            .subscribe { [weak self] state in
                guard let state  = state.element as? TaskViewType else {
                    return
                }
                self?.configureViewState(state, performedType: task.perfomedViewType)
        }.disposed(by: rxBag)

        progressButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.userChangedPerformType.onNext(true)
            })
            .disposed(by: rxBag)

    }

    private func configureViewState(_ state: TaskViewType, performedType: PerformedTaskType) {
        switch state {
        case .completed(let rating):
            resolveCompletedState(rating: rating)
        case .performed(let data):
            resolvePerformedState(performedType: performedType,
                                  time: data.timeBeforeEnding,
                                  procentage: data.procentage)
        case .awaitingCompletion(let timeBeforeStarting):
            resolveAwaitingCompletionState(timeBeforeStarting: timeBeforeStarting)
        }
    }

    private func resolveCompletedState(rating: TaskRating?) {
        stateLabel.text = Constants.completedTitle
        ratingView.configure(with: rating ?? .notRaited, isSelectable: false)
        progressView.isHidden = rating == .notRaited
        ratingView.isHidden = rating == .notRaited
        awatingRatingLabel.isHidden = rating != .notRaited
    }

    private func resolvePerformedState(performedType: PerformedTaskType, time: String, procentage: Double) {
        stateLabel.text = Constants.performedTitle
        awatingRatingLabel.isHidden = true
        ratingView.isHidden = true
        switch performedType {
        case .time:
            setProgressInfo(metric: time, description: Constants.beforeEndingTitle)
        case .procentage:
            setProgressInfo(metric: "\(Int(procentage).description)%", description: Constants.completedTitle)
        }
        progressView.layer.configureCircleProgress(progress: procentage / Constants.procentageDevider,
                                                   lineWidth: Constants.circleProgressLineWidth,
                                                   color: UIColor.green.cgColor)
    }

    private func resolveAwaitingCompletionState(timeBeforeStarting: String) {
        awatingRatingLabel.isHidden = true
        ratingView.isHidden = true
        stateLabel.text = Constants.beforeStartingTitle
        setProgressInfo(metric: timeBeforeStarting, description: Constants.awaitingStateTitle)
    }

    private func setProgressInfo(metric: String?, description: String?) {
        infoMetricLabel.text = metric
        infoDescriptionLabel.text = description
    }

    private func setupPriorityView(with priority: TaskPriority) {
        switch priority {
        case .notRaited:
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
        priorityView.layer.cornerRadius = priorityView.frame.size.height / Constants.halfViewSizeDevider
        descriptionLabel.numberOfLines = .max
        taskView.layer.shadowColor = UIColor.lightGray.cgColor
        taskView.layer.shadowOpacity = Constants.taskViewShadowOpacity
        taskView.layer.shadowOffset = .zero
        taskView.layer.shadowRadius = Constants.taskViewShadowRadius
        taskView.layer.cornerRadius = Constants.taskViewCornerRadius
    }
}
