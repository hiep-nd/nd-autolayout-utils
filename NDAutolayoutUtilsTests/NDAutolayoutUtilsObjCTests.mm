//
//  NDAutolayoutUtilsTests.mm
//  NDAutolayoutUtilsTests
//
//  Created by Nguyen Duc Hiep on 2/11/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <XCTest/XCTest.h>

#import <NDAutolayoutUtils/NDAutolayoutUtils.h>

@interface NDAutolayoutUtilsTests : XCTestCase

@end

@implementation NDAutolayoutUtilsTests

- (void)test {
  NDApplyConstraintRatio(1, [[UIView alloc] init]);
}

@end
