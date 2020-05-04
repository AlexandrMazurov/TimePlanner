//
//  NibLoadable.swift
//  TimePlannerApp
//
//  Created by Mazurov, Aleksandr on 5/2/20.
//  Copyright © 2020 AlexandrMazurov. All rights reserved.
//

import UIKit

protocol NibLoadable {
    func loadFromNib()
}

extension NibLoadable where Self: UIView {
    func loadFromNib() {
        let viewType = type(of: self)
        let viewName = String(describing: viewType)
        let bundle = Bundle(for: viewType)
        let nib = UINib(nibName: viewName, bundle: bundle)
        if let nibView = nib.instantiate(withOwner: self, options: nil).first as? UIView {
            nibView.frame = bounds
            nibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            addSubview(nibView)
        }
    }
}
