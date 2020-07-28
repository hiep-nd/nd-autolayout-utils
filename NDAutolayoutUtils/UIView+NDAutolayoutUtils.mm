//
//  UIView+NDAutolayoutUtils.mm
//  NDAutolayoutUtils
//
//  Created by Nguyen Duc Hiep on 7/15/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <NDAutolayoutUtils/UIView+NDAutolayoutUtils.h>

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

NDCommonLayoutGuidesContainer_Default_Impl

    @end
