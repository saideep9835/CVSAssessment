//
//  FlickrInterviewUITests.swift
//  FlickrInterviewUITests
//
//  Created by Saideep Reddy Talusani on 10/14/24.
//

import XCTest

final class FlickrInterviewUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        // Setup before each test
        app = XCUIApplication()
        app.launch()

        // Stop execution if a failure occurs
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        // Cleanup after each test
        app = nil
    }

    // MARK: - Test Cases

    /// Test if the app launches and the search bar exists
    func testSearchBarExists() throws {
        let searchBar = app.textFields["Search"]
        XCTAssertTrue(searchBar.exists, "Search bar should exist on the main screen.")
    }

    /// Test performing a search and checking for results
    func testSearchFunctionality() throws {
        let searchBar = app.textFields["Search"]
        XCTAssertTrue(searchBar.exists, "Search bar should exist on the main screen.")

        searchBar.tap()
        searchBar.typeText("Nature")
       

        // Wait for results to load
        let firstCell = app.scrollViews.images.firstMatch
        let exists = firstCell.waitForExistence(timeout: 5) // Adjust timeout if necessary
        XCTAssertTrue(exists, "The first image should load after performing a search.")
    }

    /// Test if "No Results Found" is displayed for an invalid search


    // Measure app launch performance
    @MainActor
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                app.launch()
            }
        }
    }
}
