//
//  ActivityModel.swift
//  FitnessLogger
//
//  Created by Nicholas Dobos on 4/3/18.
//  Copyright © 2018 TestOrg. All rights reserved.
//

import Foundation

struct ActivityModel: Codable {
    let name: String
    let distance: Double
    let type: String
    let date: Date

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case distance = "distance"
        case type = "type"
        case date = "start_date_local"
    }
}
