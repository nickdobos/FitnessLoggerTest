//
//  Coordinator.swift
//  FitnessLogger
//
//  Created by Nicholas Dobos on 4/1/18.
//  Copyright © 2018 TestOrg. All rights reserved.
//

import UIKit


// Loosely based on http://khanlou.com/2015/10/coordinators-redux/ and http://aplus.rs/2017/mvc-c-injecting-coordinator-pattern-in-uikit/
class Coordinator: NSObject {
    // MARK: - Lifecycle

    init(rootViewController: UINavigationController, parent: Coordinator?) {
        self.rootNavigationController = rootViewController
        self.parentCoordinator = parent
    }

    // MARK: - Coordinator

    let rootNavigationController: UINavigationController
    weak var parentCoordinator: Coordinator? = nil

    private var childCoordinators: [Coordinator] = []

    func start() {
        // Empty Superclass method
    }

    func coordinatorDidFinish(_ coordinator: Coordinator) {
        if let index = childCoordinators.index(of: coordinator) {
            childCoordinators.remove(at: index)
        }
    }
}
