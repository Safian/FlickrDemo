//
//  DefaultDataManager.swift
//  FlickrDemo
//
//  Created by Szabolcs Sáfián on 2025. 08. 09..
//

import Foundation

final class DefaultDataManager: DataManager {
    private let userDefaults = UserDefaults.standard
    private let lastSearchQueryKey = "lastQuery"

    func saveLastSearch(text: String) {
        userDefaults.set(text, forKey: lastSearchQueryKey)
    }

    func loadLastSearch() -> String? {
        userDefaults.string(forKey: lastSearchQueryKey)
    }
}
