//
//  DependencyInjection.swift
//  FlickrDemo
//
//  Created by Szabolcs Sáfián on 2025. 08. 08..
//

import Swinject

let container = Container()

func setupDependencies() {
    container.register(FlickrAPIService.self) { _ in FlickrAPIServiceImpl() }
    container.register(DataManager.self) { _ in DefaultDataManager() }
    container.register(ViewModelFactory.self) { resolver in
        DefaultViewModelFactory(apiService: resolver.resolve(FlickrAPIService.self)!,
                                dataManager: resolver.resolve(DataManager.self)!)
    }
}
