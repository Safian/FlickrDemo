//
//  ViewModelFactory.swift
//  FlickrDemo
//
//  Created by Szabolcs Sáfián on 2025. 08. 08..
//

protocol ViewModelFactory {
    func makeSearchViewModel() -> SearchViewModel
}
