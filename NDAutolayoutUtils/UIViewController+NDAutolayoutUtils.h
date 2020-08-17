//
//  UIViewController+NDAutolayoutUtils.h
//  NDAutolayoutUtils
//
//  Created by Nguyen Duc Hiep on 8/17/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (NDAutolayoutUtils)

/// Add child view controllers. All child view controllers view will be set
/// translatesAutoresizingMaskIntoConstraints to NO.
/// @param childViewControllers The child view controllers.
- (void)nd_addChildViewControllers:
    (NSArray<UIViewController*>*)childViewControllers
    NS_SWIFT_NAME(nd_add(childViewControllers:));
- (void)nd_addChildViewControllers:
            (NSArray<UIViewController*>*)childViewControllers
    translatesAutoresizingMaskIntoConstraints:
        (NSNumber* _Nullable)translatesAutoresizingMaskIntoConstraints
    NS_REFINED_FOR_SWIFT;
- (void)nd_fillWithContentViewController:
    (UIViewController*)contentViewController NS_SWIFT_NAME(nd_fill(with:));

@end

NS_ASSUME_NONNULL_END
