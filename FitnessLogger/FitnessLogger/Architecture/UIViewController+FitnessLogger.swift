//
//  UIViewController+FitnessLogger.swift
//  FitnessLogger
//
//  Created by Nicholas Dobos on 4/1/18.
//  Copyright © 2018 TestOrg. All rights reserved.
//

import UIKit

extension UIViewController {
    static func instantiateFromStoryboard() -> UIViewController {
        let identifier = String(describing: self)
        let viewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifier)

        return viewController
    }
}
