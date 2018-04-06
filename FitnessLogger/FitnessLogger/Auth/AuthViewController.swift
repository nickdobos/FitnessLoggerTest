//
//  AuthViewController.swift
//  FitnessLogger
//
//  Created by Nicholas Dobos on 4/1/18.
//  Copyright © 2018 TestOrg. All rights reserved.
//

import UIKit

protocol AuthViewControllerDelegate: class {
    func didAuthorize()
}

final class AuthViewController: UIViewController {

    // MARK: - AuthViewController

    func setupWith(authManager: AuthManager) {
        manager = authManager
        manager.delegate = self
    }

    weak var delegate: AuthViewControllerDelegate? = nil

    private var manager: AuthManager!

    private func sendAuthorizationRequest() {
        manager.sendAuthorizationRequest()
    }

    private func displayFailureAlert() {
        textLabel.text = NSLocalizedString("Failure authorizing. Please Try again", comment: "Failed to authorize")
        textLabel.textColor = UIColor.red
    }

    // MARK: - Outlets

    @IBOutlet weak var authorizeButton: UIButton!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!

    // MARK: - Actions

    @IBAction func authButtonPressed(_ sender: Any) {
        sendAuthorizationRequest()
        authorizeButton.isHidden = true

        loadingIndicator.isHidden = false
        loadingIndicator.startAnimating()
    }
}

extension AuthViewController: AuthManagerDelegate {
    func didAuthorize() {
        delegate?.didAuthorize()
    }
}
