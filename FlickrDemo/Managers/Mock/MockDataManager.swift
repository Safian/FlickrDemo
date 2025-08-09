//
//  MockDataManager.swift
//  FlickrDemo
//
//  Created by Szabolcs Sáfián on 2025. 08. 09..
//

final class MockDataManager: DataManager {
    var loadLastSearchHandler: (() -> String?)?
    var savedText: String?

    func loadLastSearch() -> String? {
        loadLastSearchHandler?() ?? "last search"
    }

    func saveLastSearch(text: String) {
        savedText = text
    }
}
