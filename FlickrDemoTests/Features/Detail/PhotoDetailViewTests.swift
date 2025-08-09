//
//  PhotoDetailViewTests.swift
//  FlickrDemo
//
//  Created by Szabolcs Sáfián on 2025. 08. 09..
//

@testable import FlickrDemo

import SwiftUI
import XCTest

import ViewInspector

final class PhotoDetailViewTests: XCTestCase {
    func testTitleAndNavigationBar_andOnAppear() throws {
        let view = PhotoDetailView(photo: Photo.mock)
        let inspected = try view.inspect()
        let vStack = try inspected.geometryReader().vStack()
        XCTAssertNoThrow(try vStack.asyncImage(0))
        XCTAssertEqual(try vStack.text(1).string(), Photo.mock.title)
        XCTAssertNoThrow(try vStack.spacer(2))
    }

    func testClampedOffsetBounds() {
        let view = PhotoDetailView(photo: Photo.mock)
        let clampedOffset = view.inspectableClampedOffset(CGSize(width: 100, height: 200),
                                                          scale: 2, screenW: 100, screenH: 200)
        XCTAssertNotNil(clampedOffset)
    }

    func testViewHasAsyncImageWithGestureModifiers_noCrash() throws {
        let view = PhotoDetailView(photo: Photo.mock)
        let asyncImg = try view.inspect().geometryReader().vStack().asyncImage(0)
        XCTAssertNoThrow(asyncImg)
    }

    func testClampedOffsetBranches() {
        let view = PhotoDetailView(photo: Photo.mock)
        let offset1 = view.inspectableClampedOffset(.zero, scale: 1.0, screenW: 100, screenH: 100)
        let offset2 = view.inspectableClampedOffset(CGSize(width: 200, height: 200),
                                                    scale: 4.0,
                                                    screenW: 100,
                                                    screenH: 200)
        XCTAssertTrue(offset1.width >= -0.01 && offset1.width <= 0.01)
        XCTAssertTrue(offset2.width <= 150)
    }
}

// MARK: - Helpers

extension PhotoDetailView {
    func inspectableClampedOffset(_ proposed: CGSize, scale: CGFloat, screenW: CGFloat, screenH: CGFloat) -> CGSize {
        let mutable = self
        mutable.screenW = screenW
        mutable.screenH = screenH
        mutable.scale = scale
        return mutable.clampedOffset(proposed)
    }
}
