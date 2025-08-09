//
//  FlickrAPIServiceImpl.swift
//  FlickrDemo
//
//  Created by Szabolcs Sáfián on 2025. 08. 08..
//

import Combine
import Foundation

final class FlickrAPIServiceImpl: FlickrAPIService {
    private let urlSession: URLSession
    private let scheduler: DispatchQueue

    init(urlSession: URLSession = .shared, scheduler: DispatchQueue = .main) {
        self.urlSession = urlSession
        self.scheduler = scheduler
    }

    func searchPhotos(text: String, page: Int) -> AnyPublisher<[Photo], Error> {
        var components = URLComponents(string: FLICKR_URL)!
        components.queryItems = [
            URLQueryItem(name: "method", value: "flickr.photos.search"),
            URLQueryItem(name: "api_key", value: FLICKR_API_KEY),
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "nojsoncallback", value: "1"),
            URLQueryItem(name: "text", value: text),
            URLQueryItem(name: "per_page", value: "\(FLICKR_PAGE_SIZE)"),
            URLQueryItem(name: "page", value: "\(page)")
        ]
        guard let url = components.url else {
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }
        return urlSession.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: PhotoSearchResponse.self, decoder: JSONDecoder())
            .map(\.photos.photo)
            .receive(on: scheduler)
            .eraseToAnyPublisher()
    }
}
