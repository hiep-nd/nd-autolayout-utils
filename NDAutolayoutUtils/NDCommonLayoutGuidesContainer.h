//
//  NDCommonLayoutGuidesContainer.h
//  NDAutolayoutUtils
//
//  Created by Nguyen Duc Hiep on 7/15/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(NDCommonLayoutGuidesContainerProtocol)
@protocol NDCommonLayoutGuidesContainer <NSObject>

@property(nonatomic, strong, readonly) UILayoutGuide* nd_leadingGuide;
@property(nonatomic, strong, readonly) UILayoutGuide* nd_trailingGuide;
@property(nonatomic, strong, readonly) UILayoutGuide* nd_leftGuide;
@property(nonatomic, strong, readonly) UILayoutGuide* nd_rightGuide;
@property(nonatomic, strong, readonly) UILayoutGuide* nd_topGuide;
@property(nonatomic, strong, readonly) UILayoutGuide* nd_bottomGuide;
@property(nonatomic, strong, readonly) UILayoutGuide* nd_centerGuide;
@property(nonatomic, assign) UIEdgeInsets nd_padding;
@property(nonatomic, strong, readonly) UILayoutGuide* nd_paddingGuide;

@end

NS_ASSUME_NONNULL_END
