//
//  UIViewController+Present.swift
//  TimePlannerApp
//
//  Created by Mazurov, Aleksandr on 4/15/20.
//  Copyright © 2020 AlexandrMazurov. All rights reserved.
//

import UIKit

extension UIViewController {

    func presentWithFlipAnimation(viewController: UIViewController) {
        viewController.modalTransitionStyle = .flipHorizontal
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)
    }
}
