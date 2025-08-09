//
//  SearchViewModel.swift
//  FlickrDemo
//
//  Created by Szabolcs Sáfián on 2025. 08. 08..
//

import Combine
import Foundation

@MainActor
final class SearchViewModel: ObservableObject {
    private let apiService: FlickrAPIService
    private let dataManager: DataManager
    private var cancellables = Set<AnyCancellable>()

    @Published var photos: [Photo] = []
    @Published var searchText: String = ""
    @Published var isLoading = false

    private var currentPage = 1
    private var currentSearchText = FLICKR_DEFAULT_SEARCH_TEXT

    init(apiService: FlickrAPIService, dataManager: DataManager) {
        self.apiService = apiService
        self.dataManager = dataManager
    }

    func loadInitialPhotos() {
        let savedQuery = dataManager.loadLastSearch() ?? currentSearchText
        searchPhotos(searchText: savedQuery)
    }

    func searchPhotos(searchText: String) {
        guard !isLoading else { return }
        currentPage = 1
        currentSearchText = searchText
        dataManager.saveLastSearch(text: searchText)
        fetchPhotos(query: searchText, page: currentPage, append: false)
    }

    func loadMore(at index: Int) {
        guard !isLoading, index == photos.count - 1 else { return }
        currentPage += 1
        fetchPhotos(query: currentSearchText, page: currentPage, append: true)
    }

    private func fetchPhotos(query: String, page: Int, append: Bool) {
        isLoading = true
        apiService.searchPhotos(text: query, page: page)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case let .failure(error) = completion {
                    print("Error: \(error)")
                }
            }, receiveValue: { [weak self] result in
                if append {
                    self?.photos.append(contentsOf: result)
                } else {
                    self?.photos = result
                }
            })
            .store(in: &cancellables)
    }
}
