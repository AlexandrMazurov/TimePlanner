//
//  TaskCell.swift
//  TimePlannerApp
//
//  Created by Mazurov, Aleksandr on 5/6/20.
//  Copyright © 2020 AlexandrMazurov. All rights reserved.
//

import UIKit

class AppearanceConfig: AppearanceConfigProtocol {

    let colors: AppearanceColorsConfigProtocol?
    var fonts: AppearanceFontsConfigProtocol?

    init(colorsConfig: AppearanceColorsConfigProtocol?, fontsConfig: AppearanceFontsConfigProtocol?) {
        self.colors = colorsConfig
        self.fonts = fontsConfig
    }
}
