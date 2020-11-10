//
//  UIViewController+NDAutolayoutUtils.mm
//  NDAutolayoutUtils
//
//  Created by Nguyen Duc Hiep on 8/17/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <NDAutolayoutUtils/UIViewController+NDAutolayoutUtils.h>

#import <NDAutolayoutUtils/NDVisualConstraintUtils.h>
#import <NDAutolayoutUtils/UIView+NDAutolayoutUtils.h>
#import <NDLog/NDLog.h>

@implementation UIViewController (NDAutolayoutUtils)

- (void)nd_addChildViewControllers:
    (NSArray<UIViewController*>*)childViewControllers {
  [self nd_addChildViewControllers:childViewControllers
      translatesAutoresizingMaskIntoConstraints:@(NO)];
}

- (void)nd_addChildViewControllers:(NSArray<UIView*>*)childViewControllers
    translatesAutoresizingMaskIntoConstraints:
        (NSNumber*)translatesAutoresizingMaskIntoConstraints {
  if (translatesAutoresizingMaskIntoConstraints != nil) {
    auto translates = translatesAutoresizingMaskIntoConstraints.boolValue;
    for (UIViewController* vc in childViewControllers) {
      [self addChildViewController:vc];
      vc.view.translatesAutoresizingMaskIntoConstraints = translates;
      [self.view addSubview:vc.view];
      [vc didMoveToParentViewController:self];
    }
  } else {
    for (UIViewController* vc in childViewControllers) {
      [self addChildViewController:vc];
      [self.view addSubview:vc.view];
      [vc didMoveToParentViewController:self];
    }
  }
}

- (void)nd_fillWithContentViewController:
    (UIViewController*)contentViewController {
  if (!contentViewController) {
    NDAssertionFailure(@"Can not fill with content view controller: '%@'.",
                       contentViewController);
    return;
  }

  [self nd_addChildViewControllers:@[ contentViewController ]];
  NDApplyVisualConstraints(@[ @"V:|[content]|", @"H:|[content]|" ],
                           @{@"content" : contentViewController.view});
}

@end
