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

    // MARK: - Coordinator

    override init(rootViewController: UINavigationController, parent: Coordinator?) {
        authManager = AuthManager()

        super.init(rootViewController: rootViewController, parent: parent)
    }

    var authManager: AuthManager

    override func start() {
        if authManager.needsAuth {
            showAuth()
        } else {
            showActivites()
        }
    }

    // MARK: - AppCoordinator

    private func showAuth() {
        let auth = AuthViewController.instantiateFromStoryboard() as! AuthViewController
        let authManager = AuthManager()
        authManager.delegate = self
        auth.setupWith(authManager:  authManager)

        rootNavigationController.setViewControllers([auth], animated: true)
    }

    private func showActivites() {

    }
}

extension AppCoordinator: AuthManagerDelegate {
    func didAuthorize() {
        showActivites()
    }
}
