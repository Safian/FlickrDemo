//
//  SearchView.swift
//  FlickrDemo
//
//  Created by Szabolcs Sáfián on 2025. 08. 08..
//

import SwiftUI

struct SearchView: View {
    @StateObject var viewModel: SearchViewModel

    private let columns = [
        GridItem(.flexible(), spacing: paddingDefault),
        GridItem(.flexible(), spacing: paddingDefault)
    ]

    var body: some View {
        NavigationStack {
            VStack {
                TextField("Search photos...", text: $viewModel.searchText)
                    .textFieldStyle(.roundedBorder)
                    .autocorrectionDisabled()
                    .padding(.horizontal, paddingDefault)
                    .onSubmit {
                        viewModel.searchPhotos(searchText: viewModel.searchText)
                    }

                ScrollView {
                    LazyVGrid(columns: columns, spacing: paddingDefault) {
                        ForEach(viewModel.photos.indices, id: \.self) { index in
                            let photo = viewModel.photos[index]

                            NavigationLink {
                                PhotoDetailView(photo: photo)
                            } label: {
                                PhotoCell(photo: photo)
                            }
                            .onAppear {
                                viewModel.loadMore(at: index)
                            }
                        }

                        if viewModel.isLoading, !viewModel.photos.isEmpty {
                            ProgressView()
                                .frame(maxWidth: .infinity)
                                .padding()
                            ProgressView()
                                .frame(maxWidth: .infinity)
                                .padding()
                        }
                    }
                    .padding(.horizontal, paddingDefault)
                    .padding(.top, paddingDefault)
                }
            }
            .navigationTitle("Flickr Search")
            .onAppear {
                viewModel.loadInitialPhotos()
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(
            viewModel: SearchViewModel(
                apiService: MockFlickrAPIService(),
                dataManager: MockDataManager()
            )
        )
    }
}
