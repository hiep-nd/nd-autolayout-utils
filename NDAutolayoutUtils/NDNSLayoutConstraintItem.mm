//
//  NDNSLayoutConstraintItem.mm
//  NDAutolayoutUtils
//
//  Created by Nguyen Duc Hiep on 7/15/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <NDAutolayoutUtils/NDNSLayoutConstraintItem.h>

#import "Privates/NDNSLayoutConstraintItemUtils.h"

using namespace nd::autolayout;

@implementation UIView (NDNSLayoutConstraintItem)

+ (void)load {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    SwizzleMethods(UIView.class, {
      std::make_tuple(@selector(addLayoutGuide:),
                      @selector(nd_swizzled_addLayoutGuide:)),
          std::make_tuple(@selector(removeLayoutGuide:),
                          @selector(nd_swizzled_removeLayoutGuide:)),
    });
  });
}

- (void)nd_swizzled_addLayoutGuide:(UILayoutGuide*)layoutGuide {
  auto oldContainer = layoutGuide.owningView;
  [self nd_swizzled_addLayoutGuide:layoutGuide];
  SetOwnerView(oldContainer, self, layoutGuide);
}

- (void)nd_swizzled_removeLayoutGuide:(UILayoutGuide*)layoutGuide {
  auto oldContainer = layoutGuide.owningView;
  [self nd_swizzled_removeLayoutGuide:layoutGuide];
  ResetOwnerView(oldContainer, layoutGuide);
}

// MARK: - NDNSLayoutConstraintItem

NDNSLayoutConstraintItem_LayoutGuides_Default_Impl;

- (UIView*)nd_containerView {
  return self.superview;
}

- (void)nd_addToContainerView:(UIView* _Nullable)containerView {
  [self nd_addToContainerView:containerView
      translatesAutoresizingMaskIntoConstraints:@(NO)];
}

- (void)nd_addToContainerView:(UIView* _Nullable)containerView
    translatesAutoresizingMaskIntoConstraints:
        (NSNumber* _Nullable)translatesAutoresizingMaskIntoConstraints {
  if (containerView) {
    if (translatesAutoresizingMaskIntoConstraints != nil) {
      self.translatesAutoresizingMaskIntoConstraints =
          translatesAutoresizingMaskIntoConstraints.boolValue;
    }
    [containerView addSubview:self];
  } else {
    [self removeFromSuperview];
  }
}
@end

@implementation UILayoutGuide (NDNSLayoutConstraintItem)

NDNSLayoutConstraintItem_LayoutGuides_Default_Impl;

- (UIView*)nd_containerView {
  return self.owningView;
}

- (void)nd_addToContainerView:(UIView* _Nullable)containerView {
  if (containerView) {
    [containerView addLayoutGuide:self];
  } else {
    [self.owningView removeLayoutGuide:self];
  }
}

- (void)nd_addToContainerView:(UIView* _Nullable)containerView
    translatesAutoresizingMaskIntoConstraints:
        (NSNumber* _Nullable)translatesAutoresizingMaskIntoConstraints {
  [self nd_addToContainerView:containerView];
}

@end
