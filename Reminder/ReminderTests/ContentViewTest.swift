//
//  ContentViewTest.swift
//  ReminderTests
//
//  Created by Dev on 02/12/25.
//
import XCTest
import SwiftUI
import UIKit
@testable import Reminder

final class ContentViewTests: XCTestCase {
    func test_containsHelloWorldLabel() {
        let sut = ContentView()
        let hosting = UIHostingController(rootView: sut)
        hosting.loadViewIfNeeded()

        let label = hosting.view.findLabel(withText: "Hello, world!")
        XCTAssertNotNil(label, "ContentView should contain a label with text \"Hello, world!\"")
    }

    func test_containsImageView() {
        let sut = ContentView()
        let hosting = UIHostingController(rootView: sut)
        hosting.loadViewIfNeeded()

        let imageViews = hosting.view.findImageViews()
        XCTAssertFalse(imageViews.isEmpty, "ContentView should contain at least one image view (the system image)")
    }
}

// MARK: - UIView helpers for searching subview hierarchy

private extension UIView {
    func findLabel(withText text: String) -> UILabel? {
        if let label = self as? UILabel, label.text == text {
            return label
        }
        for sub in subviews {
            if let found = sub.findLabel(withText: text) {
                return found
            }
        }
        return nil
    }

    func findImageViews() -> [UIImageView] {
        var results: [UIImageView] = []
        if let iv = self as? UIImageView {
            results.append(iv)
        }
        for sub in subviews {
            results.append(contentsOf: sub.findImageViews())
        }
        return results
    }
}
