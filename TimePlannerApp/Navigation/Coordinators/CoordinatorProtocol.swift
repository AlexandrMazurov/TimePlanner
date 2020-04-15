//
//  CoordinatorProtocol.swift
//  TimePlannerApp
//
//  Created by Mazurov, Aleksandr on 2/22/20.
//  Copyright © 2020 AlexandrMazurov. All rights reserved.
//

import UIKit

protocol CoordinatorProtocol: class {
    var childsCoordinators: [CoordinatorProtocol?] { get set }
    var rootViewController: UIViewController { get set }
    
    func start()
}
