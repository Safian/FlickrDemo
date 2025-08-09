//
//  PhotosPage.swift
//  FlickrDemo
//
//  Created by Szabolcs Sáfián on 2025. 08. 08..
//

struct PhotosPage: Decodable {
    let page: Int
    let pages: Int
    let perpage: Int
    let photo: [Photo]
}
