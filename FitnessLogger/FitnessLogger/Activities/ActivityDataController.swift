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

    func fetchActivities(completion: @escaping ([ActivityModel], Error?) -> Void){
        var activitiesURL = URLComponents(string: "https://www.strava.com/api/v3/athlete/activities")
        let queryComponents = [URLQueryItem(name: "access_token", value: token)]
        activitiesURL?.queryItems = queryComponents

        guard let fullURL = activitiesURL?.url else { return }

        var request = URLRequest(url: fullURL)
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601

            guard let responseData = data,
                error == nil,
                let activities = try? decoder.decode([ActivityModel].self, from: responseData) else {
                    completion([], error)

                    return
            }

            DispatchQueue.main.async {
                completion(activities, nil)
            }
        }

        task.resume()
    }

    func createActivity(with activityModel: ActivityModel, completion: @escaping (Error?) -> Void) {
        var activitiesURL = URLComponents(string: "https://www.strava.com/api/v3/activities")

        let dateFormatter = ISO8601DateFormatter()
        let dateString = dateFormatter.string(from: activityModel.date)

        let queryComponents = [URLQueryItem(name: ActivityModel.CodingKeys.name.stringValue, value: activityModel.name),
                               URLQueryItem(name: ActivityModel.CodingKeys.distance.stringValue, value: "\(activityModel.distance)"),
                               URLQueryItem(name: ActivityModel.CodingKeys.time.stringValue, value: "\(activityModel.time)"),
                               URLQueryItem(name: ActivityModel.CodingKeys.type.stringValue, value: activityModel.type),
                               URLQueryItem(name: ActivityModel.CodingKeys.date.stringValue, value: dateString),
                               URLQueryItem(name: "access_token", value: token)]
        activitiesURL?.queryItems = queryComponents

        guard let fullURL = activitiesURL?.url else { return }

        var request = URLRequest(url: fullURL)
        request.httpMethod = "POST"

        let task = URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
            guard let _ = data,
                error == nil else {
                    completion(error)

                    return
            }

            DispatchQueue.main.async {
                completion(nil)
            }
        }

        task.resume()
    }

    private let token: String
}
