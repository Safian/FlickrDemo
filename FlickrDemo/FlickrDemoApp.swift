//
//  FlickrDemoApp.swift
//  FlickrDemo
//
//  Created by Szabolcs Sáfián on 2025. 08. 08..
//

import SwiftUI

@main
struct FlickrDemoApp: App {
    init() {
        setupDependencies()
    }

    var body: some Scene {
        WindowGroup {
            let factory = container.resolve(ViewModelFactory.self)!
            SearchView(viewModel: factory.makeSearchViewModel())
        }
    }
}
