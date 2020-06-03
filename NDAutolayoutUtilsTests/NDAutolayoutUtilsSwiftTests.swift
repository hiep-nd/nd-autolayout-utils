//
//  NDAutolayoutUtilsSwiftTests.swift
//  NDAutolayoutUtilsTests
//
//  Created by Nguyen Duc Hiep on 6/3/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

import NDAutolayoutUtils
import XCTest

class NDAutolayoutUtilsSwiftTests: XCTestCase {
  func testExample() {

    nd_apply(views: ["view": UIView()], ratios: ["view": 1])
  }
}
