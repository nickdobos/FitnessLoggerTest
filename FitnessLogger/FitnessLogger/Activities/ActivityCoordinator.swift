//
//  ActivityCoordinator.swift
//  FitnessLogger
//
//  Created by Nicholas Dobos on 4/3/18.
//  Copyright © 2018 TestOrg. All rights reserved.
//

import Foundation
import UIKit

final class ActivityCoordinator: Coordinator {

    // MARK: - Lifecycle

    init(rootNavigationController rootViewController: UINavigationController, parent: Coordinator?, authManager: AuthManager) {
        self.authManager = authManager

        // Token is presumed to exist before reaching this coordinator
        dataController = ActivityDataController(token: authManager.accessToken!)

        super.init(rootNavigationController: rootViewController, parent: parent)
    }

    // MARK: - Coordinator

    override func start() {
        super.start()

        showListView()
    }

    // MARK: - Activity Coordinator

    let authManager: AuthManager
    let dataController: ActivityDataController

    private func showListView() {
        let listViewController = ActivityListViewController.instantiateFromStoryboard() as! ActivityListViewController
        listViewController.delegate = self
        listViewController.dataController = dataController

        rootNavigationController.pushViewController(listViewController, animated: true)
    }

    private func showCreateView() {
        let createViewController = ActivityCreateViewController.instantiateFromStoryboard() as! ActivityCreateViewController
        createViewController.delegate = self
        createViewController.dataController = dataController

        rootNavigationController.pushViewController(createViewController, animated: true)
    }

    private func showDetailView(for activity: ActivityModel) {
        let detailViewController = ActivityDetailViewController.instantiateFromStoryboard() as! ActivityDetailViewController
        detailViewController.configure(with: activity)

        rootNavigationController.pushViewController(detailViewController, animated: true)
    }
}

extension ActivityCoordinator: ActivityListViewControllerDelegate {
    func didPressActivityCell(for activity: ActivityModel) {
        showDetailView(for: activity)
    }

    func didPressAddActivityButton() {
        showCreateView()
    }
}

extension ActivityCoordinator: ActivityCreateViewControllerDelegate {
    func createdNewActivity() {
        rootNavigationController.popViewController(animated: true)
    }
}
