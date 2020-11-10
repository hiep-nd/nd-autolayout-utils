//
//  NDAutolayoutUtils_SwiftTests.swift
//  NDAutolayoutUtils_SwiftTests
//
//  Created by Nguyen Duc Hiep on 6/25/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

import XCTest

@testable import NDAutolayoutUtils

// swiftlint:disable:next type_name
class NDAutolayoutUtils_SwiftTests: XCTestCase {
  func testApply() {
    nd_apply(items: ["view": UIView()], ratios: ["view": 1])
  }

  func testExample() throws {
    let parent = UIView()
    let view = UIView()
    parent.nd_add(
      subviews: [view], translatesAutoresizingMaskIntoConstraints: true)
    parent.nd_add(items: [UIView(), UILayoutGuide()])
  }
}
