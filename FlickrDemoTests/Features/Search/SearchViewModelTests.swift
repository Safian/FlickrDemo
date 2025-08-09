//
//  SearchViewModelTests.swift
//  FlickrDemo
//
//  Created by Szabolcs Sáfián on 2025. 08. 09..
//

import Combine
@testable import FlickrDemo
import XCTest

final class SearchViewModelTests: XCTestCase {
    var cancellables = Set<AnyCancellable>()

    func testLoadInitialPhotosLoadsSavedQuery() async throws {
        let mockDataManager = MockDataManager()
        mockDataManager.loadLastSearchHandler = { "cat" }

        let mockAPI = MockFlickrAPIService()

        let viewModel = await SearchViewModel(apiService: mockAPI, dataManager: mockDataManager)

        let expectation = expectation(description: "Photos loaded with saved query")

        let photosSink = await viewModel.$photos
            .dropFirst()
            .sink { photos in
                XCTAssertEqual(photos.count, 20)
                expectation.fulfill()
            }

        await viewModel.loadInitialPhotos()

        await fulfillment(of: [expectation], timeout: 2)

        photosSink.cancel()
    }

    func testSearchPhotosUpdatesPhotosAndSavesQuery() async throws {
        let mockDataManager = MockDataManager()
        let mockAPI = MockFlickrAPIService()
        let viewModel = await SearchViewModel(apiService: mockAPI, dataManager: mockDataManager)

        let searchTerm = "bird"
        let expectation = expectation(description: "SearchPhotos updates photos and saves last query")

        let sink = await viewModel.$photos
            .dropFirst()
            .sink { photos in
                XCTAssertEqual(photos.count, 20)
                XCTAssertEqual(mockDataManager.savedText, searchTerm)
                expectation.fulfill()
            }

        await viewModel.searchPhotos(searchText: searchTerm)

        await fulfillment(of: [expectation], timeout: 2)
        sink.cancel()
    }

    func testLoadMoreAppendsPhotos() async throws {
        let mockDataManager = MockDataManager()
        let mockAPI = MockFlickrAPIService()
        let viewModel = await SearchViewModel(apiService: mockAPI, dataManager: mockDataManager)

        let expectation = expectation(description: "LoadMore appends photos")

        var loadMoreCalled = false

        let sink = await viewModel.$photos
            .dropFirst()
            .sink { photos in
                if photos.count == 20, !loadMoreCalled {
                    loadMoreCalled = true
                    Task {
                        await viewModel.loadMore(at: photos.count - 1)
                    }
                } else if photos.count == 40 {
                    expectation.fulfill()
                }
            }

        await viewModel.searchPhotos(searchText: "dog")

        await fulfillment(of: [expectation], timeout: 2)
        sink.cancel()
    }
}
