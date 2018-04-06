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
}
