//
//  ViewController.swift
//  TimePlannerApp
//
//  Created by Александр on 2/16/20.
//  Copyright © 2020 AlexandrMazurov. All rights reserved.
//

import UIKit

class LaunchViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        guard let coordinator = coordinator as? MainCoordinator else {
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            coordinator.navigateToMainFlow()
        }
        
    }


}

