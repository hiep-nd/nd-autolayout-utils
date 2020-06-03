//
//  ClassicalConstraintUtils.m
//  NDAutolayoutUtils
//
//  Created by Nguyen Duc Hiep on 2/19/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <NDAutolayoutUtils/ClassicalConstraintUtils.h>

void NDApplyConstraintRatio(CGFloat constraintRatio, id view) {
  NDConstraintRatio(constraintRatio, view).active = YES;
}

namespace nd {
void ApplyConstraintRatio(CGFloat constraintRatio, id view) {
  NDApplyConstraintRatio(constraintRatio, view);
}
}

void NDApplyConstraintRatios(
    NSDictionary<NSString*, NSNumber*>* constraintRatios,
    NSDictionary<NSString*, id>* views) {
  [NSLayoutConstraint
      activateConstraints:NDConstraintRatios(constraintRatios, views)];
}

namespace nd {
void ApplyConstraintRatios(NSDictionary<NSString*, NSNumber*>* constraintRatios,
                           NSDictionary<NSString*, id>* views) {
  NDApplyConstraintRatios(constraintRatios, views);
}
}

NSLayoutConstraint* NDConstraintRatio(CGFloat constraintRatio, id view) {
  return [NSLayoutConstraint constraintWithItem:view
                                      attribute:NSLayoutAttributeWidth
                                      relatedBy:NSLayoutRelationEqual
                                         toItem:view
                                      attribute:NSLayoutAttributeHeight
                                     multiplier:constraintRatio
                                       constant:0];
}

namespace nd {
NSLayoutConstraint* ConstraintRatio(CGFloat constraintRatio, id view) {
  return NDConstraintRatio(constraintRatio, view);
}
}

NSArray<NSLayoutConstraint*>* NDConstraintRatios(
    NSDictionary<NSString*, NSNumber*>* constraintRatios,
    NSDictionary<NSString*, id>* views) {
  __block auto constraints =
      [[NSMutableArray alloc] initWithCapacity:constraintRatios.count];
  [constraintRatios
      enumerateKeysAndObjectsUsingBlock:^(NSString* key, NSNumber* obj, BOOL*) {
        id view = views[key];
        if (view) {
          [constraints addObject:NDConstraintRatio(obj.doubleValue, view)];
        }
      }];
  return constraints.copy;
}

namespace nd {
NSArray<NSLayoutConstraint*>* ConstraintRatios(
    NSDictionary<NSString*, NSNumber*>* constraintRatios,
    NSDictionary<NSString*, id>* views) {
  return NDConstraintRatios(constraintRatios, views);
}
}
