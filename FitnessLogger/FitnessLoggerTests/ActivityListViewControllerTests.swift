//
//  ActivityListViewControllerTests.swift
//  FitnessLoggerTests
//
//  Created by Nicholas Dobos on 4/25/18.
//  Copyright © 2018 TestOrg. All rights reserved.
//

import XCTest
@testable import FitnessLogger

class ActivityListViewControllerTests: XCTestCase {
    var viewController: ActivityListViewController!

    override func setUp() {
        super.setUp()

        viewController = ActivityListViewController.instantiateFromStoryboard() as! ActivityListViewController
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testViewWillAppearCalledFetch() {
        let mockDataController = MockActiviyDataController(token: "123")
        viewController.dataController = mockDataController

        let expect = expectation(description: "Fetch activities did complete")
        mockDataController.expect = expect

        viewController.viewWillAppear(true)

        waitForExpectations(timeout: 100) { (error) in
            guard error == nil else {
                XCTFail()

                return
            }

            XCTAssert(self.viewController.dataSource.count == 2, "Data source does not have 2 items")
            expect.fulfill()
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    class MockActiviyDataController: ActivityDataController {
        var expect: XCTestExpectation? = nil

        override func fetchActivities(completion: @escaping ([ActivityModel], Error?) -> Void) {
            let mockActivity = ActivityModel(name: "Morning Run", distance: 5, time: 50, type: "Run", date: Date())
            let mockActivity2 = ActivityModel(name: "Evening Run", distance: 5, time: 50, type: "Run", date: Date())

            completion([mockActivity, mockActivity2], nil)
            expect?.fulfill()
        }
    }
}


