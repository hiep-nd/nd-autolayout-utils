//
//  NDClassicalConstraintUtils.m
//  NDAutolayoutUtils
//
//  Created by Nguyen Duc Hiep on 2/19/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <NDAutolayoutUtils/NDClassicalConstraintUtils.h>

namespace nd {
namespace autolayout {
NSArray<NSLayoutConstraint*>* ConstraintRatios(
    NSDictionary<NSString*, NSNumber*>* constraintRatios,
    NSDictionary<NSString*, id<NDNSLayoutConstraintItem>>* items) {
  return NDConstraintRatios(constraintRatios, items);
}

NSLayoutConstraint* ConstraintRatio(CGFloat constraintRatio,
                                    id<NDNSLayoutConstraintItem> item) {
  return NDConstraintRatio(constraintRatio, item);
}

void ApplyConstraintRatios(
    NSDictionary<NSString*, NSNumber*>* constraintRatios,
    NSDictionary<NSString*, id<NDNSLayoutConstraintItem>>* items) {
  NDApplyConstraintRatios(constraintRatios, items);
}

void ApplyConstraintRatio(CGFloat constraintRatio,
                          id<NDNSLayoutConstraintItem> item) {
  NDApplyConstraintRatio(constraintRatio, item);
}
}
}

NSArray<NSLayoutConstraint*>* NDConstraintRatios(
    NSDictionary<NSString*, NSNumber*>* constraintRatios,
    NSDictionary<NSString*, id<NDNSLayoutConstraintItem>>* items) {
  __block auto constraints =
      [[NSMutableArray alloc] initWithCapacity:constraintRatios.count];
  [constraintRatios
      enumerateKeysAndObjectsUsingBlock:^(NSString* key, NSNumber* obj, BOOL*) {
        id<NDNSLayoutConstraintItem> item = items[key];
        if (item) {
          [constraints addObject:NDConstraintRatio(obj.doubleValue, item)];
        }
      }];
  return constraints.copy;
}

NSLayoutConstraint* NDConstraintRatio(CGFloat constraintRatio,
                                      id<NDNSLayoutConstraintItem> item) {
  return [NSLayoutConstraint constraintWithItem:item
                                      attribute:NSLayoutAttributeWidth
                                      relatedBy:NSLayoutRelationEqual
                                         toItem:item
                                      attribute:NSLayoutAttributeHeight
                                     multiplier:constraintRatio
                                       constant:0];
}

void NDApplyConstraintRatios(
    NSDictionary<NSString*, NSNumber*>* constraintRatios,
    NSDictionary<NSString*, id<NDNSLayoutConstraintItem>>* items) {
  [NSLayoutConstraint
      activateConstraints:NDConstraintRatios(constraintRatios, items)];
}

void NDApplyConstraintRatio(CGFloat constraintRatio,
                            id<NDNSLayoutConstraintItem> item) {
  NDConstraintRatio(constraintRatio, item).active = YES;
}
