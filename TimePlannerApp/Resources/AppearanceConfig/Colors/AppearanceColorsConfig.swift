//
//  TaskCell.swift
//  TimePlannerApp
//
//  Created by Mazurov, Aleksandr on 5/6/20.
//  Copyright © 2020 AlexandrMazurov. All rights reserved.
//

import UIKit

class AppearanceColorsConfig: AppearanceColorsConfigProtocol {

    var cellColor: UIColor = {
        if #available(iOS 13, *) {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    return ColorName.pitchDark.color
                } else {
                    return UIColor.white
                }
            }
        } else {
            return UIColor.white
        }
    }()

    var cellShadow: UIColor = {
        if #available(iOS 13, *) {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    return UIColor.darkGray
                } else {
                    return UIColor.lightGray
                }
            }
        } else {
            return UIColor.lightGray
        }
    }()
}
