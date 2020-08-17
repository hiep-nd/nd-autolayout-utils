//
//  UIView+NDAutolayoutUtils.mm
//  NDAutolayoutUtils
//
//  Created by Nguyen Duc Hiep on 7/15/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <NDAutolayoutUtils/UIView+NDAutolayoutUtils.h>

#import <NDAutolayoutUtils/VisualConstraintUtils.h>
#import <NDLog/NDLog.h>

#import "Privates/NDCommonLayoutGuidesContainerUtils.h"

using namespace nd;

@implementation UIView (NDAutolayoutUtils)

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

NDCommonLayoutGuidesContainer_Default_Impl;

- (void)nd_addSubviews:(NSArray<UIView*>*)views {
  [self nd_addSubviews:views translatesAutoresizingMaskIntoConstraints:@(NO)];
}

- (void)nd_addSubviews:(NSArray<UIView*>*)views
    translatesAutoresizingMaskIntoConstraints:
        (NSNumber*)translatesAutoresizingMaskIntoConstraints {
  if (translatesAutoresizingMaskIntoConstraints != nil) {
    auto translates = translatesAutoresizingMaskIntoConstraints.boolValue;
    for (UIView* v in views) {
      v.translatesAutoresizingMaskIntoConstraints = translates;
      [self addSubview:v];
    }
  } else {
    for (UIView* v in views) {
      [self addSubview:v];
    }
  }
}

- (void)nd_fillWithContentView:(UIView*)contentView {
  AddAndAnchor(self, self, contentView);
}

- (void)nd_fillMarginWithContentView:(UIView*)contentView {
  AddAndAnchor(self, self.layoutMarginsGuide, contentView);
}

namespace {
template <typename T>
inline void AddAndAnchor(UIView* container, T* anchor, UIView* contentView) {
  if (!contentView) {
    NDCAssertionFailure(@"Can not fill view: '%@' with content view: '%@'.",
                        container, contentView);
    return;
  }

  [container nd_addSubviews:@[ contentView ]];
  NDApplyVisualConstraints(@[ @"V:|[content]|", @"H:|[content]|" ],
                           @{@"content" : contentView});
}
}

@end
