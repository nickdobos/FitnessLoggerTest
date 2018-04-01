//
//  AuthManager.swift
//  FitnessLogger
//
//  Created by Nicholas Dobos on 4/1/18.
//  Copyright © 2018 TestOrg. All rights reserved.
//

import UIKit

final class AuthManager {

    struct k {
        static let clientID = "24599"
        static let clientSecret = "42539bc9d42e4e010b271068eac7f577fb5206ba"
        static let accessToken = "70e503a654438ce02ea4a06b6714ad579be5b8d0"
        static let redirectURI = "FitnessLogger://auth"
    }

    var needsAuth = true

    func sendAuthorizationRequest() {
        var components = URLComponents(string: "https://www.strava.com/oauth/authorize")
        let queryComponents = [URLQueryItem(name: "client_id", value: k.clientID),
                               URLQueryItem(name: "redirect_uri", value: k.redirectURI),
                               URLQueryItem(name: "response_type", value: "code")]
        components?.queryItems = queryComponents

        guard let fullURL = components?.url else { return; }

        UIApplication.shared.open(fullURL, options: [:], completionHandler: nil)
    }

    func handleTokenCallback(withURL url: URL) {
        guard let queryItems = URLComponents(url: url, resolvingAgainstBaseURL: true)?.queryItems else {
            // handle gerneic error

            return
        }

        if let codeQuery = queryItems.first(where: { $0.name == "code" }), let code = codeQuery.value {
            sendTokenRequest(withCode: code)
        } else if let errorQuery = queryItems.first(where: { $0.name == "error" }), errorQuery.value == "access denied" {
            // TODO: Handle bad access error
        } else {
            // handle some generic error
        }
    }

    private func sendTokenRequest(withCode code: String) {
        var authTokenURLComponents = URLComponents(string: "https://www.strava.com/oauth/token")
        let queryComponents = [URLQueryItem(name: "client_id", value: k.clientID),
                               URLQueryItem(name: "client_secret", value: k.clientSecret),
                               URLQueryItem(name: "code", value: code)]
        authTokenURLComponents?.queryItems = queryComponents

        guard let fullURL = authTokenURLComponents?.url else { return }

        var request = URLRequest(url: fullURL)
        request.httpMethod = "POST"

        URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
            // TODO: Handle this response
        }
    }
}
