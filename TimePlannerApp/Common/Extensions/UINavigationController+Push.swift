//
//  UINavigationController+Push.swift
//  TimePlannerApp
//
//  Created by Mazurov, Aleksandr on 2/23/20.
//  Copyright © 2020 AlexandrMazurov. All rights reserved.
//

import UIKit


extension UINavigationController {

    func pushViewControllerWithFlipAnimation(viewController:UIViewController){
        self.pushViewController(viewController
        , animated: false)
        if let transitionView = self.view{
            UIView.transition(with:transitionView, duration: 0.8, options: .transitionFlipFromLeft, animations: nil, completion: nil)
        }
    }

    func popViewControllerWithFlipAnimation(){
        self.popViewController(animated: false)
        if let transitionView = self.view{
            UIView.transition(with:transitionView, duration: 0.8, options: .transitionFlipFromRight, animations: nil, completion: nil)
        }
    }
}
