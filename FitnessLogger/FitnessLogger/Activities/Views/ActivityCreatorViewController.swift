//
//  ActivityCreatorViewController.swift
//  FitnessLogger
//
//  Created by Nicholas Dobos on 4/3/18.
//  Copyright © 2018 TestOrg. All rights reserved.
//

import Foundation
import UIKit

protocol ActivityCreateViewControllerDelegate: class {
    func createdNewActivity()
}

final class ActivityCreateViewController: UIViewController {

    // MARK: UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.isNavigationBarHidden = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        navigationController?.isNavigationBarHidden = true
    }

    // MARK: ActivityCreateViewController

    weak var delegate: ActivityCreateViewControllerDelegate? = nil
    var dataController: ActivityDataController!

    // MARK: - Outlets

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var distanceTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!

    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!

    @IBAction func createButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text,
            let distanceString = distanceTextField.text,
            let distance = Double(distanceString),
            let timeString = timeTextField.text,
            let time = Int(timeString) else {
                // TODO: Handle error
                return
        }

        let activity = ActivityModel(name: name, distance: distance, time: time, type: "Yoga", date: Date())

        createButton.isHidden = true
        loadingIndicator.isHidden = false
        loadingIndicator.startAnimating()
        resignFirstResponder()

        dataController.createActivity(with: activity) { [weak self] (error) in
            guard error == nil else {
                // TODO: Handle error
                return
            }

            self?.delegate?.createdNewActivity()
        }
    }
}
