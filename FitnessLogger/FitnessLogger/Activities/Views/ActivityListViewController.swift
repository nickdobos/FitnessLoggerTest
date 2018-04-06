//
//  ActivityListViewController.swift
//  FitnessLogger
//
//  Created by Nicholas Dobos on 4/3/18.
//  Copyright © 2018 TestOrg. All rights reserved.
//

import Foundation
import UIKit

protocol ActivityListViewControllerDelegate: class {
    func didPressAddActivityButton()
    func didPressActivityCell(for activity: ActivityModel)
}

final class ActivityListViewController: UIViewController {

    // MARK: - UIViewController

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        fetchActivities()
    }

    // MARK: - ActivityListViewController

    weak var delegate: ActivityListViewControllerDelegate? = nil
    var dataController: ActivityDataController!

    func fetchActivities() {
        dataController.fetchActivities { [weak self] (activities, error) in
            guard error == nil else {
                DispatchQueue.main.async {
                    self?.loadingLabel.text = NSLocalizedString("Something went wrong", comment: "oops")
                    self?.activityIndicator.stopAnimating()

                }

                return
            }

            self?.dataSource = activities

            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.tableView.isHidden = false
            }
        }
    }

    private var dataSource = [ActivityModel]()

    @IBOutlet weak var loadingLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    @IBOutlet weak var tableView: UITableView!

    // MARK: - Actions

    @IBAction func addActivityButtonPressed(_ sender: Any) {
        delegate?.didPressAddActivityButton()
    }
}

extension ActivityListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityCell", for: indexPath)
        let activityForCell = dataSource[indexPath.row]
        cell.textLabel?.text = activityForCell.name

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let activityForCell = dataSource[indexPath.row]
        delegate?.didPressActivityCell(for: activityForCell)
    }
}
