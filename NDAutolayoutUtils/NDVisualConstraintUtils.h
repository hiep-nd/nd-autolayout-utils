//
//  NDVisualConstraintUtils.h
//  NDAutolayoutUtils
//
//  Created by Nguyen Duc Hiep on 2/11/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <NDAutolayoutUtils/NDNSLayoutConstraintItem.h>

// MARK: - ObjC++
#ifdef __cplusplus
namespace nd {
namespace autolayout {
/// Returns constraints based on the visual constraint with options described
/// with |visualConstraintWithOptions|, |metrics| and |ratios| to items in
/// |items|.
NSArray<NSLayoutConstraint*>* _Nonnull Visual(
    NSDictionary<NSString*, NSNumber*>* _Nullable visualConstraintWithOptions,
    NSDictionary<NSString*, id<NDNSLayoutConstraintItem>>* _Nonnull items,
    NSDictionary<NSString*, NSNumber*>* _Nullable metrics = nil,
    NSDictionary<NSString*, NSNumber*>* _Nullable ratios = nil);

/// Returns constraints based on the visual constraints described with
/// |visualConstraints|, |metrics| and |ratios| to items in |items|.
NSArray<NSLayoutConstraint*>* _Nonnull Visual(
    NSArray<NSString*>* _Nullable visualConstraints,
    NSDictionary<NSString*, id<NDNSLayoutConstraintItem>>* _Nonnull items,
    NSDictionary<NSString*, NSNumber*>* _Nullable metrics = nil,
    NSDictionary<NSString*, NSNumber*>* _Nullable ratios = nil);

/// Applies all |visualConstraintWithOptions| with |metrics|, |ratios| to
/// items in |items|
void Apply(
    NSDictionary<NSString*, NSNumber*>* _Nullable visualConstraintWithOptions,
    NSDictionary<NSString*, id<NDNSLayoutConstraintItem>>* _Nonnull items,
    NSDictionary<NSString*, NSNumber*>* _Nullable metrics,
    NSDictionary<NSString*, NSNumber*>* _Nullable ratios);

/// Applies all |visualConstraints| with |metrics| and ratios to items in
/// |items|.
void Apply(
    NSArray<NSString*>* _Nullable visualConstraints,
    NSDictionary<NSString*, id<NDNSLayoutConstraintItem>>* _Nonnull items,
    NSDictionary<NSString*, NSNumber*>* _Nullable metrics = nil,
    NSDictionary<NSString*, NSNumber*>* _Nullable ratios = nil);
}  // autolayout
}  // nd
#endif

// MARK: - NDVisualConstraintWithOptionsWithMetricsAndRatios
/// Returns constraints based on the visual constraint with options described
/// with |visualConstraintWithOptions|, |metrics| and |ratios| to items in
/// |items|.
FOUNDATION_EXPORT
NSArray<NSLayoutConstraint*>* _Nonnull NDVisualConstraintWithOptionsWithMetricsAndRatios(
    NSDictionary<NSString*, NSNumber*>* _Nullable visualConstraintWithOptions,
    NSDictionary<NSString*, id<NDNSLayoutConstraintItem>>* _Nonnull items,
    NSDictionary<NSString*, NSNumber*>* _Nullable metrics,
    NSDictionary<NSString*, NSNumber*>* _Nullable ratios) NS_REFINED_FOR_SWIFT;

/// Returns constraints based on the visual constraint with options described
/// with |visualConstraintWithOptions| and |metrics| to items in |items|.
FOUNDATION_EXPORT
inline NSArray<NSLayoutConstraint*>* _Nonnull NDVisualConstraintWithOptionsWithMetrics(
    NSDictionary<NSString*, NSNumber*>* _Nullable visualConstraintWithOptions,
    NSDictionary<NSString*, id<NDNSLayoutConstraintItem>>* _Nonnull items,
    NSDictionary<NSString*, NSNumber*>* _Nullable metrics)
    NS_SWIFT_UNAVAILABLE("For ObjC only.") {
  return NDVisualConstraintWithOptionsWithMetricsAndRatios(
      visualConstraintWithOptions, items, metrics, nil);
}

/// Returns constraints based on the visual constraint with options described
/// with |visualConstraintWithOptions| to items in |items|.
FOUNDATION_EXPORT
inline NSArray<NSLayoutConstraint*>* _Nonnull NDVisualConstraintWithOptions(
    NSDictionary<NSString*, NSNumber*>* _Nullable visualConstraintWithOptions,
    NSDictionary<NSString*, id<NDNSLayoutConstraintItem>>* _Nonnull items)
    NS_SWIFT_UNAVAILABLE("For ObjC only.") {
  return NDVisualConstraintWithOptionsWithMetricsAndRatios(
      visualConstraintWithOptions, items, nil, nil);
}

// MARK: - NDVisualConstraintsWithMetricsAndRatios
/// Returns constraints based on the visual constraints described with
/// |visualConstraints|, |metrics| and |ratios| to items in |items|.
FOUNDATION_EXPORT
NSArray<NSLayoutConstraint*>* _Nonnull NDVisualConstraintsWithMetricsAndRatios(
    NSArray<NSString*>* _Nullable visualConstraints,
    NSDictionary<NSString*, id<NDNSLayoutConstraintItem>>* _Nonnull items,
    NSDictionary<NSString*, NSNumber*>* _Nullable metrics,
    NSDictionary<NSString*, NSNumber*>* _Nullable ratios) NS_REFINED_FOR_SWIFT;

/// Returns constraints based on the visual constraints described with
/// |visualConstraints| and |metrics| to items in |items|.
FOUNDATION_EXPORT
inline NSArray<NSLayoutConstraint*>* _Nonnull NDVisualConstraintsWithMetrics(
    NSArray<NSString*>* _Nullable visualConstraints,
    NSDictionary<NSString*, id<NDNSLayoutConstraintItem>>* _Nonnull items,
    NSDictionary<NSString*, NSNumber*>* _Nullable metrics)
    NS_SWIFT_UNAVAILABLE("For ObjC only.") {
  return NDVisualConstraintsWithMetricsAndRatios(visualConstraints, items,
                                                 metrics, nil);
}

/// Returns constraints based on the visual constraints described with
/// |visualConstraints| to items in |items|.
FOUNDATION_EXPORT
inline NSArray<NSLayoutConstraint*>* _Nonnull NDVisualConstraints(
    NSArray<NSString*>* _Nullable visualConstraints,
    NSDictionary<NSString*, id<NDNSLayoutConstraintItem>>* _Nonnull items)
    NS_SWIFT_UNAVAILABLE("For ObjC only.") {
  return NDVisualConstraintsWithMetricsAndRatios(visualConstraints, items, nil,
                                                 nil);
}

// MARK: - NDApplyVisualConstraintWithOptionsWithMetricsAndRatios
/// Applies all |visualConstraintWithOptions| with |metrics|, |ratios| to items
/// in |items|
FOUNDATION_EXPORT
void NDApplyVisualConstraintWithOptionsWithMetricsAndRatios(
    NSDictionary<NSString*, NSNumber*>* _Nullable visualConstraintWithOptions,
    NSDictionary<NSString*, id<NDNSLayoutConstraintItem>>* _Nonnull items,
    NSDictionary<NSString*, NSNumber*>* _Nullable metrics,
    NSDictionary<NSString*, NSNumber*>* _Nullable ratios) NS_REFINED_FOR_SWIFT;

/// Applies all |visualConstraintWithOptions| with |metrics| to items in |items|
FOUNDATION_EXPORT
inline void NDApplyVisualConstraintWithOptionsWithMetrics(
    NSDictionary<NSString*, NSNumber*>* _Nullable visualConstraintWithOptions,
    NSDictionary<NSString*, id<NDNSLayoutConstraintItem>>* _Nonnull items,
    NSDictionary<NSString*, NSNumber*>* _Nullable metrics)
    NS_SWIFT_UNAVAILABLE("For ObjC only.") {
  NDApplyVisualConstraintWithOptionsWithMetricsAndRatios(
      visualConstraintWithOptions, items, metrics, nil);
}

/// Applies all |visualConstraintWithOptions| to items in |items|
FOUNDATION_EXPORT
inline void NDApplyVisualConstraintWithOptions(
    NSDictionary<NSString*, NSNumber*>* _Nullable visualConstraintWithOptions,
    NSDictionary<NSString*, id<NDNSLayoutConstraintItem>>* _Nonnull items,
    NSDictionary<NSString*, NSNumber*>* _Nullable metrics)
    NS_SWIFT_UNAVAILABLE("For ObjC only.") {
  NDApplyVisualConstraintWithOptionsWithMetricsAndRatios(
      visualConstraintWithOptions, items, nil, nil);
}

// MARK: - NDApplyVisualConstraintsWithMetricsAndRatios
/// Applies all |visualConstraints| with |metrics|, |ratios| to items in |items|
FOUNDATION_EXPORT
void NDApplyVisualConstraintsWithMetricsAndRatios(
    NSArray<NSString*>* _Nullable visualConstraints,
    NSDictionary<NSString*, id<NDNSLayoutConstraintItem>>* _Nonnull items,
    NSDictionary<NSString*, NSNumber*>* _Nullable metrics,
    NSDictionary<NSString*, NSNumber*>* _Nullable ratios) NS_REFINED_FOR_SWIFT;

/// Applies all |visualConstraints| with |metrics| to items in |items|
FOUNDATION_EXPORT
inline void NDApplyVisualConstraintsWithMetrics(
    NSArray<NSString*>* _Nullable visualConstraints,
    NSDictionary<NSString*, id<NDNSLayoutConstraintItem>>* _Nonnull items,
    NSDictionary<NSString*, NSNumber*>* _Nullable metrics)
    NS_SWIFT_UNAVAILABLE("For ObjC only.") {
  NDApplyVisualConstraintsWithMetricsAndRatios(visualConstraints, items,
                                               metrics, nil);
}

/// Applies all |visualConstraints| to items in |items|
FOUNDATION_EXPORT
inline void NDApplyVisualConstraints(
    NSArray<NSString*>* _Nullable visualConstraints,
    NSDictionary<NSString*, id<NDNSLayoutConstraintItem>>* _Nonnull items)
    NS_SWIFT_UNAVAILABLE("For ObjC only.") {
  NDApplyVisualConstraintsWithMetricsAndRatios(visualConstraints, items, nil,
                                               nil);
}
