//
//  ActivityDataController.swift
//  FitnessLogger
//
//  Created by Nicholas Dobos on 4/3/18.
//  Copyright © 2018 TestOrg. All rights reserved.
//

import Foundation

final class ActivityDataController {

    // MARK: - Lifecycle

    init(token: String) {
        self.token = token
    }

    // MARK: - ActivityDataController

    func fetchActivities(completion: @escaping ([ActivityModel], Error?) -> Void ){
        var activitiesURL = URLComponents(string: "https://www.strava.com/api/v3/athlete/activities")
        let queryComponents = [URLQueryItem(name: "access_token", value: token)]
        activitiesURL?.queryItems = queryComponents

        guard let fullURL = activitiesURL?.url else { return }

        var request = URLRequest(url: fullURL)
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
            guard let responseData = data,
                error == nil,
                let activities = try? JSONDecoder().decode([ActivityModel].self, from: responseData) else {
                    completion([], error)

                    return
            }

            completion(activities, nil)
        }

        task.resume()
    }

    private let token: String
}
