//
//  Photo.swift
//  FlickrDemo
//
//  Created by Szabolcs Sáfián on 2025. 08. 08..
//

import Foundation

struct Photo: Decodable, Identifiable, Equatable {
    let id: String
    let owner: String
    let secret: String
    let server: String
    let title: String

    var imageUrl: URL? {
        URL(string: "https://live.staticflickr.com/\(server)/\(id)_\(secret)_m.jpg")
    }

    var largeImageUrl: URL? {
        URL(string: "https://live.staticflickr.com/\(server)/\(id)_\(secret)_b.jpg")
    }
}
