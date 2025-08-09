//
//  MockFlickrAPIService.swift
//  FlickrDemo
//
//  Created by Szabolcs Sáfián on 2025. 08. 09..
//

import Combine

final class MockFlickrAPIService: FlickrAPIService {
    func searchPhotos(text _: String, page _: Int) -> AnyPublisher<[Photo], Error> {
        let mockPhotos = (1 ... 20).map { _ in Photo.mock }
        return Just(mockPhotos)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
