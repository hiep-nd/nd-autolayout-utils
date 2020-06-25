//
//  NSObject+NDAutolayoutUtils.mm
//  NDAutolayoutUtils
//
//  Created by Nguyen Duc Hiep on 3/4/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <NDAutolayoutUtils/NSObject+NDAutolayoutUtils.h>

#import <objc/runtime.h>

@implementation NSObject (NDAutolayoutUtils)

- (UILayoutGuide*)nd_leadingGuide {
  return GetGuide(self, @selector(nd_leadingGuide), NSLayoutAttributeTop,
                  NSLayoutAttributeTop, NSLayoutAttributeBottom,
                  NSLayoutAttributeBottom, NSLayoutAttributeLeading,
                  NSLayoutAttributeLeading, NSLayoutAttributeTrailing,
                  NSLayoutAttributeLeading);
}

- (UILayoutGuide*)nd_trailingGuide {
  return GetGuide(self, @selector(nd_trailingGuide), NSLayoutAttributeTop,
                  NSLayoutAttributeTop, NSLayoutAttributeBottom,
                  NSLayoutAttributeBottom, NSLayoutAttributeLeading,
                  NSLayoutAttributeTrailing, NSLayoutAttributeTrailing,
                  NSLayoutAttributeTrailing);
}

- (UILayoutGuide*)nd_leftGuide {
  return GetGuide(
      self, @selector(nd_leftGuide), NSLayoutAttributeTop, NSLayoutAttributeTop,
      NSLayoutAttributeBottom, NSLayoutAttributeBottom, NSLayoutAttributeLeft,
      NSLayoutAttributeLeft, NSLayoutAttributeRight, NSLayoutAttributeLeft);
}

- (UILayoutGuide*)nd_rightGuide {
  return GetGuide(self, @selector(nd_rightGuide), NSLayoutAttributeTop,
                  NSLayoutAttributeTop, NSLayoutAttributeBottom,
                  NSLayoutAttributeBottom, NSLayoutAttributeLeft,
                  NSLayoutAttributeRight, NSLayoutAttributeRight,
                  NSLayoutAttributeRight);
}

- (UILayoutGuide*)nd_topGuide {
  return GetGuide(
      self, @selector(nd_topGuide), NSLayoutAttributeTop, NSLayoutAttributeTop,
      NSLayoutAttributeBottom, NSLayoutAttributeTop, NSLayoutAttributeLeft,
      NSLayoutAttributeLeft, NSLayoutAttributeRight, NSLayoutAttributeRight);
}

- (UILayoutGuide*)nd_bottomGuide {
  return GetGuide(self, @selector(nd_bottomGuide), NSLayoutAttributeTop,
                  NSLayoutAttributeBottom, NSLayoutAttributeBottom,
                  NSLayoutAttributeBottom, NSLayoutAttributeLeft,
                  NSLayoutAttributeLeft, NSLayoutAttributeRight,
                  NSLayoutAttributeRight);
}

- (UILayoutGuide*)nd_centerGuide {
  return GetGuide(self, @selector(nd_centerGuide), NSLayoutAttributeTop,
                  NSLayoutAttributeCenterY, NSLayoutAttributeBottom,
                  NSLayoutAttributeCenterY, NSLayoutAttributeLeft,
                  NSLayoutAttributeCenterX, NSLayoutAttributeRight,
                  NSLayoutAttributeCenterX);
}

namespace {
inline NSLayoutConstraint* Anchor(id item1,
                                  id item2,
                                  NSLayoutAttribute attr1,
                                  NSLayoutAttribute attr2) {
  return [NSLayoutConstraint constraintWithItem:item1
                                      attribute:attr1
                                      relatedBy:NSLayoutRelationEqual
                                         toItem:item2
                                      attribute:attr2
                                     multiplier:1
                                       constant:0];
}

inline UIView* GetLayoutContainerView(id obj) {
  if ([obj isKindOfClass:UILayoutGuide.class]) {
    return ((UILayoutGuide*)obj).owningView;
  }
  if ([obj isKindOfClass:UIView.class]) {
    return ((UIView*)obj).superview;
  }
  return nil;
}

inline UILayoutGuide* GetGuide(id obj,
                               const void* key,
                               NSLayoutAttribute attrG1,
                               NSLayoutAttribute attrO1,
                               NSLayoutAttribute attrG2,
                               NSLayoutAttribute attrO2,
                               NSLayoutAttribute attrG3,
                               NSLayoutAttribute attrO3,
                               NSLayoutAttribute attrG4,
                               NSLayoutAttribute attrO4) {
  id guide = objc_getAssociatedObject(obj, key);
  if (!guide) {
    guide = [[UILayoutGuide alloc] init];
    [GetLayoutContainerView(obj) addLayoutGuide:guide];
    [NSLayoutConstraint activateConstraints:@[
      Anchor(guide, obj, attrG1, attrO1),
      Anchor(guide, obj, attrG2, attrO2),
      Anchor(guide, obj, attrG3, attrO3),
      Anchor(guide, obj, attrG4, attrO4),
    ]];

    objc_setAssociatedObject(obj, key, guide,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  }

  return guide;
}
}

@end
