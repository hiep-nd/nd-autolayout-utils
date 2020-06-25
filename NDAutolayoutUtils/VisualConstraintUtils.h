//
//  VisualConstraintUtils.h
//  NDAutolayoutUtils
//
//  Created by Nguyen Duc Hiep on 2/11/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <UIKit/UIKit.h>

/// Applies all |visualConstraints| to views in |views|.
#ifdef __cplusplus
namespace nd {
void Apply(NSArray<NSString*>* _Nullable visualConstraints,
           NSDictionary<NSString*, id>* _Nonnull views);
}
#endif
FOUNDATION_EXPORT
void NDApplyVisualConstraints(NSArray<NSString*>* _Nullable visualConstraints,
                              NSDictionary<NSString*, id>* _Nonnull views)
    NS_SWIFT_UNAVAILABLE("For ObjC only.");

/// Applies all |visualConstraints| with |metrics| to views in |views|.
#ifdef __cplusplus
namespace nd {
void Apply(NSArray<NSString*>* _Nullable visualConstraints,
           NSDictionary<NSString*, id>* _Nonnull views,
           NSDictionary<NSString*, NSNumber*>* _Nullable metrics);
}
#endif
FOUNDATION_EXPORT
void NDApplyVisualConstraintsWithMetrics(
    NSArray<NSString*>* _Nullable visualConstraints,
    NSDictionary<NSString*, id>* _Nonnull views,
    NSDictionary<NSString*, NSNumber*>* _Nullable metrics)
    NS_SWIFT_UNAVAILABLE("For ObjC only.");

/// Applies all |visualConstraints| with |metrics| and ratios to views in
/// |views|.
#ifdef __cplusplus
namespace nd {
void Apply(NSArray<NSString*>* _Nullable visualConstraints,
           NSDictionary<NSString*, id>* _Nonnull views,
           NSDictionary<NSString*, NSNumber*>* _Nullable metrics,
           NSDictionary<NSString*, NSNumber*>* _Nullable ratios);
}
#endif
FOUNDATION_EXPORT
void NDApplyVisualConstraintsWithMetricsAndRatios(
    NSArray<NSString*>* _Nullable visualConstraints,
    NSDictionary<NSString*, id>* _Nonnull views,
    NSDictionary<NSString*, NSNumber*>* _Nullable metrics,
    NSDictionary<NSString*, NSNumber*>* _Nullable ratios) NS_REFINED_FOR_SWIFT;

/// Applies all |visualConstraintWithOptions| with |metrics|, |ratios| to views
/// in |views|
#ifdef __cplusplus
namespace nd {
void Apply(
    NSDictionary<NSString*, NSNumber*>* _Nullable visualConstraintWithOptions,
    NSDictionary<NSString*, id>* _Nonnull views,
    NSDictionary<NSString*, NSNumber*>* _Nullable metrics,
    NSDictionary<NSString*, NSNumber*>* _Nullable ratios);
}
#endif
FOUNDATION_EXPORT
void NDApplyVisualConstraintWithOptionsWithMetricsAndRatios(
    NSDictionary<NSString*, NSNumber*>* _Nullable visualConstraintWithOptions,
    NSDictionary<NSString*, id>* _Nonnull views,
    NSDictionary<NSString*, NSNumber*>* _Nullable metrics,
    NSDictionary<NSString*, NSNumber*>* _Nullable ratios) NS_REFINED_FOR_SWIFT;

/// Returns constraints based on the visual constraints described
/// with |visualConstraints| to views in |views|.
#ifdef __cplusplus
namespace nd {
NSArray<NSLayoutConstraint*>* _Nonnull Visual(
    NSArray<NSString*>* _Nullable visualConstraints,
    NSDictionary<NSString*, id>* _Nonnull views);
}
#endif
FOUNDATION_EXPORT
NSArray<NSLayoutConstraint*>* _Nonnull NDVisualConstraints(
    NSArray<NSString*>* _Nullable visualConstraints,
    NSDictionary<NSString*, id>* _Nonnull views)
    NS_SWIFT_UNAVAILABLE("For ObjC only.");

/// Returns constraints based on the visual constraints described with
/// |visualConstraints| and |metrics| to views in |views|.
#ifdef __cplusplus
namespace nd {
NSArray<NSLayoutConstraint*>* _Nonnull Visual(
    NSArray<NSString*>* _Nullable visualConstraints,
    NSDictionary<NSString*, id>* _Nonnull views,
    NSDictionary<NSString*, NSNumber*>* _Nullable metrics);
}
#endif
FOUNDATION_EXPORT
NSArray<NSLayoutConstraint*>* _Nonnull NDVisualConstraintsWithMetrics(
    NSArray<NSString*>* _Nullable visualConstraints,
    NSDictionary<NSString*, id>* _Nonnull views,
    NSDictionary<NSString*, NSNumber*>* _Nullable metrics)
    NS_SWIFT_UNAVAILABLE("For ObjC only.");

/// Returns constraints based on the visual constraints described with
/// |visualConstraints|, |metrics| and |ratios| to views in |views|.
#ifdef __cplusplus
namespace nd {
NSArray<NSLayoutConstraint*>* _Nonnull Visual(
    NSArray<NSString*>* _Nullable visualConstraints,
    NSDictionary<NSString*, id>* _Nonnull views,
    NSDictionary<NSString*, NSNumber*>* _Nullable metrics,
    NSDictionary<NSString*, NSNumber*>* _Nullable ratios);
}
#endif
FOUNDATION_EXPORT
NSArray<NSLayoutConstraint*>* _Nonnull NDVisualConstraintsWithMetricsAndRatios(
    NSArray<NSString*>* _Nullable visualConstraints,
    NSDictionary<NSString*, id>* _Nonnull views,
    NSDictionary<NSString*, NSNumber*>* _Nullable metrics,
    NSDictionary<NSString*, NSNumber*>* _Nullable ratios) NS_REFINED_FOR_SWIFT;

/// Returns constraints based on the visual constraint with options described
/// with |visualConstraintWithOptions|, |metrics| and |ratios| to views in
/// |views|.
#ifdef __cplusplus
namespace nd {
NSArray<NSLayoutConstraint*>* _Nonnull Visual(
    NSDictionary<NSString*, NSNumber*>* _Nullable visualConstraintWithOptions,
    NSDictionary<NSString*, id>* _Nonnull views,
    NSDictionary<NSString*, NSNumber*>* _Nullable metrics,
    NSDictionary<NSString*, NSNumber*>* _Nullable ratios);
}
#endif
FOUNDATION_EXPORT
NSArray<NSLayoutConstraint*>* _Nonnull NDVisualConstraintWithOptionsWithMetricsAndRatios(
    NSDictionary<NSString*, NSNumber*>* _Nullable visualConstraintWithOptions,
    NSDictionary<NSString*, id>* _Nonnull views,
    NSDictionary<NSString*, NSNumber*>* _Nullable metrics,
    NSDictionary<NSString*, NSNumber*>* _Nullable ratios) NS_REFINED_FOR_SWIFT;
