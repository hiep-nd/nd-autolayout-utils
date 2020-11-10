//
//  UIView+NDAutolayoutUtils.h
//  NDAutolayoutUtils
//
//  Created by Nguyen Duc Hiep on 7/15/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <NDAutolayoutUtils/NDNSLayoutConstraintItem.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (NDAutolayoutUtils)

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
- (void)nd_addLayoutConstraintItems:
    (NSArray<id<NDNSLayoutConstraintItem>>*)items NS_SWIFT_NAME(nd_add(items:));
- (void)nd_addLayoutConstraintItems:
            (NSArray<id<NDNSLayoutConstraintItem>>*)items
    translatesAutoresizingMaskIntoConstraints:
        (NSNumber* _Nullable)translatesAutoresizingMaskIntoConstraints
    NS_REFINED_FOR_SWIFT;
- (void)nd_fillWithContentView:(UIView*)contentView
    NS_SWIFT_NAME(nd_fill(with:));
- (void)nd_fillMarginWithContentView:(UIView*)contentView
    NS_SWIFT_NAME(nd_fillMargin(with:));

+ (instancetype)nd_wrapItems:
                    (NSDictionary<NSString*, id<NDNSLayoutConstraintItem>>*)
                        items
           visualConstraints:(NSArray<NSString*>*)visualConstraints
    NS_SWIFT_NAME(nd_wrap(items:visualConstraints:));

+ (instancetype)nd_wrapItem:(id<NDNSLayoutConstraintItem>)item
          visualConstraints:(NSArray<NSString*>*)visualConstraints
    NS_SWIFT_NAME(nd_wrap(item:visualConstraints:));

/// Wrap items in |items| with |visualConstraints|. Auto add item |safeArea| and
/// |wrapper|.
/// @param items The items.
/// @param visualConstraints The visual constraints.
- (instancetype)nd_wrapItems:
                    (NSDictionary<NSString*, id<NDNSLayoutConstraintItem>>*)
                        items
           visualConstraints:(NSArray<NSString*>*)visualConstraints
    NS_SWIFT_NAME(nd_wrap(items:visualConstraints:));

- (instancetype)nd_wrapItem:(id<NDNSLayoutConstraintItem>)item
          visualConstraints:(NSArray<NSString*>*)visualConstraints
    NS_SWIFT_NAME(nd_wrap(item:visualConstraints:));

@end

#if defined(__cplusplus)

namespace nd {
namespace autolayout {

template <typename T,
          UIView* (*getter)(T) = nullptr,
          typename Ctor,
          typename... Args>
T Wrap(NSDictionary<NSString*, id<NDNSLayoutConstraintItem>>* items,
       NSArray<NSString*>* visualConstraints,
       Ctor ctor,
       Class type,
       Args&&... args) {
  T obj = ctor(type, std::forward<Args>(args)...);
  [(getter ? getter(obj) : obj) nd_wrapItems:items
                           visualConstraints:visualConstraints];
  return obj;
}
}
}

#endif

NS_ASSUME_NONNULL_END
