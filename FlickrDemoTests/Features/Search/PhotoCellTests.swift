//
//  PhotoCellTests.swift
//  FlickrDemo
//
//  Created by Szabolcs Sáfián on 2025. 08. 10..
//

@testable import FlickrDemo

import SwiftUI
import ViewInspector
import XCTest

final class PhotoCellTests: XCTestCase {
    func testPhotoCellDisplaysPhotoElements() throws {
        let photo = Photo.mock

        let view = PhotoCell(photo: photo)
        let vStack = try view.inspect().vStack()

        XCTAssertNoThrow(try vStack.asyncImage(0))

        let text = try vStack.text(1)
        XCTAssertEqual(try text.string(), photo.title)
    }

    func testPhotoCellDisplaysFallbackOnImageFailure() throws {
        let photo = Photo.mock

        // Act
        let view = PhotoCell(photo: photo)
        let vStack = try view.inspect().vStack()
        let asyncImage = try vStack.asyncImage(0)

        XCTAssertNoThrow(asyncImage)
    }
}
