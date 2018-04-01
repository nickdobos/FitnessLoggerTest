//
//  AuthViewController.swift
//  FitnessLogger
//
//  Created by Nicholas Dobos on 4/1/18.
//  Copyright © 2018 TestOrg. All rights reserved.
//

import UIKit

final class AuthViewController: UIViewController {

    func setupWith(authManager: AuthManager) {
        manager = authManager
    }

    private var manager: AuthManager!

    private func sendAuthorizationRequest() {
        manager.sendAuthorizationRequest()
    }

    private func displayFailureAlert() {
        textLabel.text = NSLocalizedString("Failure authorizing. Please Try again", comment: "Failed to authorize")
        textLabel.textColor = UIColor.red
    }

    @IBOutlet weak var textLabel: UILabel!

    // MARK: Actions

    @IBAction func authButtonPressed(_ sender: Any) {
        sendAuthorizationRequest()
    }
}
