//
//  RatingView.swift
//  TimePlannerApp
//
//  Created by Mazurov, Aleksandr on 5/2/20.
//  Copyright © 2020 AlexandrMazurov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RatingView: UIView, NibLoadable {

    @IBOutlet weak var ratingStackView: UIStackView!

    private let rxBag = DisposeBag()
    let rating = BehaviorRelay<TaskRating?>(value: nil)
    private var stackViewButtons = [UIButton]()
    private var isSelectable: Bool?

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadFromNib()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadFromNib()
    }

    func configure(with rating: TaskRating, isSelectable: Bool) {
        self.isSelectable = isSelectable
        if stackViewButtons.isEmpty {
            generateSelectableButtons(count: TaskRating.allCases.count - 1)
            makeRatingIfNeeded(rating: rating)
        }
    }

    func makeRatingIfNeeded(rating: TaskRating) {
        if rating != TaskRating.none {
            guard let ratingIndex = TaskRating.allCases.firstIndex(of: rating) else {
                return
            }
            for (index, button) in stackViewButtons.enumerated() {
                button.isSelected = index <= ratingIndex
            }
        }
    }

    private func generateSelectableButtons(count: Int) {
        for _ in 0 ..< count {
            addButtonsToStackView()
        }
    }

    private func removeAllButtons() {
        ratingStackView.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
        stackViewButtons.removeAll()
    }

    private func addButtonsToStackView() {
        let button = UIButton()
        button.heightAnchor.constraint(equalTo: button.widthAnchor).isActive = true
        button.setImage(Asset.defaultStar.image, for: .normal)
        button.setImage(Asset.selectedStar.image, for: .selected)
        ratingStackView.addArrangedSubview(button)
        stackViewButtons.append(button)
        guard let isSelectable = isSelectable, isSelectable else {
            return
        }
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }

    @objc private func buttonTapped(_ sender: UIButton) {
        guard let selectedButtonIndex = stackViewButtons.firstIndex(of: sender) else {
            return
        }
        for (index, button) in stackViewButtons.enumerated() {
            button.isSelected = index <= selectedButtonIndex
        }
        rating.accept(TaskRating(rawValue: selectedButtonIndex))
    }

}
