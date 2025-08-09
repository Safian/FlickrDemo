//
//  DefaultViewModelFactory.swift
//  FlickrDemo
//
//  Created by Szabolcs Sáfián on 2025. 08. 08..
//

class DefaultViewModelFactory: @preconcurrency ViewModelFactory {
    private let apiService: FlickrAPIService
    private let dataManager: DataManager

    init(apiService: FlickrAPIService, dataManager: DataManager) {
        self.apiService = apiService
        self.dataManager = dataManager
    }

    @MainActor
    func makeSearchViewModel() -> SearchViewModel {
        SearchViewModel(apiService: apiService, dataManager: dataManager)
    }
}
