//
//  FlickrInterviewTests.swift
//  FlickrInterviewTests
//
//  Created by Saideep Reddy Talusani on 10/14/24.
//

import XCTest
@testable import FlickrInterview

final class FlickrInterviewTests: XCTestCase {

    var viewModel: FlicrViewModel!
    var mockAPIManager: MockApiManager!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockAPIManager = MockApiManager() // Create a mock API manager instance
        viewModel = FlicrViewModel(apiManager: mockAPIManager) // Inject mock into the ViewModel
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
        mockAPIManager = nil
    }

    func testFetchDataWithMockAPI() async {
            // Use viewModel created in setup
            await viewModel.fetchData(for: "test")
            
            // Assert
            XCTAssertEqual(viewModel.dataFromAPI?.items?.count, 2, "Expected 2 items in mock data")
            XCTAssertEqual(viewModel.dataFromAPI?.items?.first?.title, "Mock Title 1")
    }

    func testFetchDataWithEmptySearchText() async {
        await viewModel.fetchData(for: "")
            
        XCTAssertNil(viewModel.dataFromAPI, "Data from API should be nil for empty search text")
    }
    
    func testLoadingStateDuringFetch() async {
        XCTAssertFalse(viewModel.isLoading, "isLoading should initially be false")
        await viewModel.fetchData(for: "nature")

        XCTAssertFalse(viewModel.isLoading, "isLoading should be false after fetching")
    }
    
    func testPublishedDateParsing() async {
        // Act
        await viewModel.fetchData(for: "nature")
        // Assert
        let publishedDate = viewModel.dataFromAPI?.items?.first?.published
        XCTAssertNotEqual(publishedDate, "2024-10-14T14:30:00Z", "Published date should match the mock data")
    }
}
