//
//  FlickrAPIService.swift
//  FlickrDemo
//
//  Created by Szabolcs Sáfián on 2025. 08. 08..
//

import Combine

protocol FlickrAPIService {
    func searchPhotos(text: String, page: Int) -> AnyPublisher<[Photo], Error>
}
