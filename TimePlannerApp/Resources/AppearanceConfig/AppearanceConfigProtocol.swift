//
//  TaskCell.swift
//  TimePlannerApp
//
//  Created by Mazurov, Aleksandr on 6/2/20.
//  Copyright © 2020 AlexandrMazurov. All rights reserved.
//

import UIKit

protocol AppearanceConfigProtocol: class {

    var colors: AppearanceColorsConfigProtocol? { get }
    var fonts: AppearanceFontsConfigProtocol? { get }
}
