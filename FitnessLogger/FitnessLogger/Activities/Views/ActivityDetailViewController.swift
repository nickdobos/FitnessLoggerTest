//
//  ActivityDetailViewController.swift
//  FitnessLogger
//
//  Created by Nicholas Dobos on 4/3/18.
//  Copyright © 2018 TestOrg. All rights reserved.
//

import Foundation
import UIKit

final class ActivityDetailViewController: UIViewController {

    // MARK: UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.isNavigationBarHidden = false

        if let model = model {
            configure(with: model)
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        navigationController?.isNavigationBarHidden = true
    }

    // MARK: - ActivityDetailViewCOntroller

    private var model: ActivityModel? = nil

    func configure(with activityModel: ActivityModel) {
        model = activityModel

        guard isViewLoaded else { return }

        nameLabel.text = activityModel.name
        distanceLabel.text = activityModel.distance == 0.0 ? NSLocalizedString("Really far trust me", comment: "I'm a great athelete") : "\(activityModel.distance)"
        typeLabel.text = activityModel.type

        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        dateLabel.text = formatter.string(from: activityModel.date)
    }

    // MARK: - Outlets

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
}
