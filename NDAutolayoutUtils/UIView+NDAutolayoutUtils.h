//
//  UIView+NDAutolayoutUtils.h
//  NDAutolayoutUtils
//
//  Created by Nguyen Duc Hiep on 7/15/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <NDAutolayoutUtils/NDCommonLayoutGuidesContainer.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (NDAutolayoutUtils) <NDCommonLayoutGuidesContainer>

/// Add subviews. All subview will be set
/// translatesAutoresizingMaskIntoConstraints to NO.
/// @param subviews The views.
- (void)nd_addSubviews:(NSArray<UIView*>*)subviews
    NS_SWIFT_NAME(nd_add(subviews:));
- (void)nd_addSubviews:(NSArray<UIView*>*)subviews
    translatesAutoresizingMaskIntoConstraints:
        (NSNumber* _Nullable)translatesAutoresizingMaskIntoConstraints
    NS_REFINED_FOR_SWIFT;
- (void)nd_addLayoutGuides:(NSArray<UILayoutGuide*>*)layoutGuides
    NS_SWIFT_NAME(nd_add(layoutGuides:));
- (void)nd_fillWithContentView:(UIView*)contentView
    NS_SWIFT_NAME(nd_fill(with:));
- (void)nd_fillMarginWithContentView:(UIView*)contentView
    NS_SWIFT_NAME(nd_fillMargin(with:));

@end

NS_ASSUME_NONNULL_END
