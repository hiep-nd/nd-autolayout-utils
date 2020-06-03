//
//  ClassicalConstraintUtils.h
//  NDAutolayoutUtils
//
//  Created by Nguyen Duc Hiep on 2/19/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <UIKit/UIKit.h>

/// Applies constraint as width by height in |constraintRatio| to view in
/// |view|.
#ifdef __cplusplus
namespace nd {
void ApplyConstraintRatio(CGFloat constraintRatio, id _Nonnull view);
}
#endif
FOUNDATION_EXPORT
void NDApplyConstraintRatio(CGFloat constraintRatio, id _Nonnull view)
    NS_SWIFT_UNAVAILABLE("For ObjC only.");

/// Applies constraints as width by height in |constraintRatios|  to views in
/// |views|.
#ifdef __cplusplus
namespace nd {
void ApplyConstraintRatios(
    NSDictionary<NSString*, NSNumber*>* _Nullable constraintRatios,
    NSDictionary<NSString*, id>* _Nonnull views);
}
#endif
FOUNDATION_EXPORT
void NDApplyConstraintRatios(
    NSDictionary<NSString*, NSNumber*>* _Nullable constraintRatios,
    NSDictionary<NSString*, id>* _Nonnull views)
    NS_SWIFT_UNAVAILABLE("For ObjC only.");

/// Returns constraint as width by height in |constraintRatio| to view in
/// |view|.
#ifdef __cplusplus
namespace nd {
NSLayoutConstraint* _Nonnull ConstraintRatio(CGFloat constraintRatio,
                                             id _Nonnull view);
}
#endif
FOUNDATION_EXPORT
NSLayoutConstraint* _Nonnull NDConstraintRatio(CGFloat constraintRatio,
                                               id _Nonnull view)
    NS_SWIFT_UNAVAILABLE("For ObjC only.");

/// Return constraints as width by height in |constraintRatios| to view in
/// |views|.
#ifdef __cplusplus
namespace nd {
NSArray<NSLayoutConstraint*>* _Nonnull ConstraintRatios(
    NSDictionary<NSString*, NSNumber*>* _Nullable constraintRatios,
    NSDictionary<NSString*, id>* _Nonnull views);
}
#endif
FOUNDATION_EXPORT
NSArray<NSLayoutConstraint*>* _Nonnull NDConstraintRatios(
    NSDictionary<NSString*, NSNumber*>* _Nullable constraintRatios,
    NSDictionary<NSString*, id>* _Nonnull views)
    NS_SWIFT_UNAVAILABLE("For ObjC only.");
