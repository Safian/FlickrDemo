//
//  FlickrAPIServiceImplTests.swift
//  FlickrDemo
//
//  Created by Szabolcs Sáfián on 2025. 08. 09..
//

@testable import FlickrDemo

import Combine
import XCTest

final class FlickrAPIServiceImplTests: XCTestCase {
    var sut: FlickrAPIServiceImpl!
    var session: URLSession!
    var cancellables = Set<AnyCancellable>()

    override func setUp() {
        super.setUp()
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        session = URLSession(configuration: config)
        sut = FlickrAPIServiceImpl(urlSession: session, scheduler: .main)
        MockURLProtocol.stubResponseData = nil
        MockURLProtocol.error = nil
    }

    override func tearDown() {
        MockURLProtocol.stubResponseData = nil
        MockURLProtocol.error = nil
        cancellables.removeAll()
        super.tearDown()
    }

    func testSearchPhotosSuccess() {
        let testTitle = "Test Photo"
        let testId = "123"
        let json = """
        {
            "photos": {
                "page": 1,
                "pages": 1,
                "perpage": 20,
                "photo": [{
                    "id": "\(testId)",
                    "owner": "testowner",
                    "secret": "abc",
                    "server": "1",
                    "title": "\(testTitle)"
                }]
            }
        }
        """
        MockURLProtocol.stubResponseData = json.data(using: .utf8)
        let expectation = expectation(description: "Photos loaded")
        var receivedPhotos: [Photo]?

        sut.searchPhotos(text: "cat", page: 1)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    XCTFail("Should not fail, error: \(error)")
                }
            }, receiveValue: { photos in
                receivedPhotos = photos
                expectation.fulfill()
            })
            .store(in: &cancellables)

        waitForExpectations(timeout: 1)
        XCTAssertEqual(receivedPhotos?.count, 1)
        XCTAssertEqual(receivedPhotos?.first?.id, testId)
        XCTAssertEqual(receivedPhotos?.first?.title, testTitle)
    }

    func testSearchPhotosInvalidData() {
        let invalidJson = """
        { "invalid": true }
        """
        MockURLProtocol.stubResponseData = invalidJson.data(using: .utf8)

        let expectation = expectation(description: "Should fail with decoding error")
        sut.searchPhotos(text: "cat", page: 1)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    expectation.fulfill()
                case .finished:
                    XCTFail("Expected failure, got success")
                }
            }, receiveValue: { photos in
                XCTFail("Should not receive photos, got \(photos)")
            })
            .store(in: &cancellables)

        waitForExpectations(timeout: 1)
    }

    func testSearchPhotosNetworkError() {
        MockURLProtocol.error = URLError(.notConnectedToInternet)
        let expectation = expectation(description: "Network error")
        sut.searchPhotos(text: "cat", page: 1)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    expectation.fulfill()
                case .finished:
                    XCTFail("Should fail for network error")
                }
            }, receiveValue: { _ in
                XCTFail("Should not receive value on error")
            })
            .store(in: &cancellables)

        waitForExpectations(timeout: 1)
    }
}
