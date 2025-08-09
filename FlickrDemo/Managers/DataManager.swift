//
//  DataManager.swift
//  FlickrDemo
//
//  Created by Szabolcs Sáfián on 2025. 08. 08..
//

import Foundation

protocol DataManager {
    func saveLastSearch(text: String)
    func loadLastSearch() -> String?
}
