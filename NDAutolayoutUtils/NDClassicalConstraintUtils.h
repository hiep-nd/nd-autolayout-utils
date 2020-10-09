//
//  NDClassicalConstraintUtils.h
//  NDAutolayoutUtils
//
//  Created by Nguyen Duc Hiep on 2/19/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <NDAutolayoutUtils/NDNSLayoutConstraintItem.h>

// MARK: - ObjC++
#ifdef __cplusplus
namespace nd {
namespace autolayout {
/// Return constraints as width by height in |constraintRatios| to item in
/// |items|.
NSArray<NSLayoutConstraint*>* _Nonnull ConstraintRatios(
    NSDictionary<NSString*, NSNumber*>* _Nullable constraintRatios,
    NSDictionary<NSString*, id<NDNSLayoutConstraintItem>>* _Nonnull items);

/// Returns constraint as width by height in |constraintRatio| to item in
/// |item|.
NSLayoutConstraint* _Nonnull ConstraintRatio(
    CGFloat constraintRatio,
    id<NDNSLayoutConstraintItem> _Nonnull item);

/// Applies constraint as width by height in |constraintRatio| to item in
/// |items|.
void Apply(
    NSDictionary<NSString*, NSNumber*>* _Nullable constraintRatios,
    NSDictionary<NSString*, id<NDNSLayoutConstraintItem>>* _Nonnull items);

/// Applies constraint as width by height in |constraintRatio| to item in
/// |items|.
void Apply(CGFloat constraintRatio, id<NDNSLayoutConstraintItem> _Nonnull item);
}
}
#endif

// MARK: - ObjC

/// Return constraints as width by height in |constraintRatios| to item in
/// |items|.
FOUNDATION_EXPORT
NSArray<NSLayoutConstraint*>* _Nonnull NDConstraintRatios(
    NSDictionary<NSString*, NSNumber*>* _Nullable constraintRatios,
    NSDictionary<NSString*, id<NDNSLayoutConstraintItem>>* _Nonnull items)
    NS_SWIFT_UNAVAILABLE("For ObjC only.");

/// Returns constraint as width by height in |constraintRatio| to item in
/// |item|.
FOUNDATION_EXPORT
NSLayoutConstraint* _Nonnull NDConstraintRatio(
    CGFloat constraintRatio,
    id<NDNSLayoutConstraintItem> _Nonnull item)
    NS_SWIFT_UNAVAILABLE("For ObjC only.");

/// Applies constraints as width by height in |constraintRatios|  to items in
/// |items|.
FOUNDATION_EXPORT
void NDApplyConstraintRatios(
    NSDictionary<NSString*, NSNumber*>* _Nullable constraintRatios,
    NSDictionary<NSString*, id<NDNSLayoutConstraintItem>>* _Nonnull items)
    NS_SWIFT_UNAVAILABLE("For ObjC only.");

/// Applies constraint as width by height in |constraintRatio| to item in
/// |items|.
FOUNDATION_EXPORT
void NDApplyConstraintRatio(CGFloat constraintRatio,
                            id<NDNSLayoutConstraintItem> _Nonnull item)
    NS_SWIFT_UNAVAILABLE("For ObjC only.");
