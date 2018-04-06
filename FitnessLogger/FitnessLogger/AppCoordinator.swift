//
//  AppCoordinator.swift
//  FitnessLogger
//
//  Created by Nicholas Dobos on 4/1/18.
//  Copyright © 2018 TestOrg. All rights reserved.
//

import Foundation

import UIKit

final class AppCoordinator: Coordinator {

    // MARK: - Lifecycle

    override init(rootNavigationController rootViewController: UINavigationController, parent: Coordinator?) {
        authManager = AuthManager()

        super.init(rootNavigationController: rootViewController, parent: parent)
    }

    // MARK: - Coordinator

    var authManager: AuthManager

    override func start() {
        super.start()

        if authManager.accessToken == nil {
            showAuth()
        } else {
            showActivites()
        }
    }

    // MARK: - AppCoordinator

    private func showAuth() {
        let auth = AuthViewController.instantiateFromStoryboard() as! AuthViewController
        auth.setupWith(authManager:  authManager)
        auth.delegate = self

        rootNavigationController.setViewControllers([auth], animated: true)
    }

    private func showActivites() {
        let activityCoordinator = ActivityCoordinator(rootNavigationController: rootNavigationController, parent: self, authManager: authManager)
        activityCoordinator.start()
    }
}

extension AppCoordinator: AuthViewControllerDelegate {
    func didAuthorize() {
        showActivites()
    }
}
