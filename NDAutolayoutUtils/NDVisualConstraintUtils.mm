//
//  NDVisualConstraintUtils.m
//  NDAutolayoutUtils
//
//  Created by Nguyen Duc Hiep on 2/11/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <NDAutolayoutUtils/NDVisualConstraintUtils.h>

#import <NDAutolayoutUtils/NDClassicalConstraintUtils.h>
#import <NDAutolayoutUtils/NDNSLayoutConstraintItem.h>

#import <NDUtils/NDUtils.h>

#import <map>

using namespace nd::objc;

namespace {
// clang-format off
inline NSMutableDictionary<NSString*, id<NDNSLayoutConstraintItem>>* BuildExtendedGuideItems(
    NSArray* visualConstraints,
    NSDictionary<NSString*, id<NDNSLayoutConstraintItem>>* items) {
  NSMutableDictionary* extendedItems = [[NSMutableDictionary alloc] init];
  [items enumerateKeysAndObjectsUsingBlock:^(NSString* name, id<NDNSLayoutConstraintItem> item, BOOL*) {
    static std::map<NSString*, UILayoutGuide* (^)(id<NDNSLayoutConstraintItem>)> guides({
      { @"leading", ^(id<NDNSLayoutConstraintItem> obj) { return obj.nd_leadingGuide; } },
      { @"trailing", ^(id<NDNSLayoutConstraintItem> obj) { return obj.nd_trailingGuide; } },
      { @"left", ^(id<NDNSLayoutConstraintItem> obj) { return obj.nd_leftGuide; } },
      { @"right", ^(id<NDNSLayoutConstraintItem> obj) { return obj.nd_rightGuide; } },
      { @"top", ^(id<NDNSLayoutConstraintItem> obj) { return obj.nd_topGuide; } },
      { @"bottom", ^(id<NDNSLayoutConstraintItem> obj) { return obj.nd_bottomGuide; } },
      { @"center", ^(id<NDNSLayoutConstraintItem> obj) { return obj.nd_centerGuide; } },
    });

    for (auto& i : guides) {
      auto guideName = [NSString stringWithFormat:@"%@_%@", name, i.first];
      if (Contain(visualConstraints, ^BOOL(NSString* c) {
            return [c containsString:guideName];
          })) {
        extendedItems[guideName] = i.second(item);
      }
    }
  }];

  return extendedItems;
}
// clang-format on
}

namespace nd {
namespace autolayout {

NSArray<NSLayoutConstraint*>* _Nonnull Visual(
    NSDictionary<NSString*, NSNumber*>* _Nullable visualConstraintWithOptions,
    NSDictionary<NSString*, id<NDNSLayoutConstraintItem>>* _Nonnull items,
    NSDictionary<NSString*, NSNumber*>* _Nullable metrics,
    NSDictionary<NSString*, NSNumber*>* _Nullable ratios) {
  return NDVisualConstraintWithOptionsWithMetricsAndRatios(
      visualConstraintWithOptions, items, metrics, ratios);
}

NSArray<NSLayoutConstraint*>* _Nonnull Visual(
    NSArray<NSString*>* _Nullable visualConstraints,
    NSDictionary<NSString*, id<NDNSLayoutConstraintItem>>* _Nonnull items,
    NSDictionary<NSString*, NSNumber*>* _Nullable metrics,
    NSDictionary<NSString*, NSNumber*>* _Nullable ratios) {
  return NDVisualConstraintsWithMetricsAndRatios(visualConstraints, items,
                                                 metrics, ratios);
}

void Apply(
    NSDictionary<NSString*, NSNumber*>* _Nullable visualConstraintWithOptions,
    NSDictionary<NSString*, id<NDNSLayoutConstraintItem>>* _Nonnull items,
    NSDictionary<NSString*, NSNumber*>* _Nullable metrics,
    NSDictionary<NSString*, NSNumber*>* _Nullable ratios) {
  NDApplyVisualConstraintWithOptionsWithMetricsAndRatios(
      visualConstraintWithOptions, items, metrics, ratios);
}

void Apply(
    NSArray<NSString*>* _Nullable visualConstraints,
    NSDictionary<NSString*, id<NDNSLayoutConstraintItem>>* _Nonnull items,
    NSDictionary<NSString*, NSNumber*>* _Nullable metrics,
    NSDictionary<NSString*, NSNumber*>* _Nullable ratios) {
  NDApplyVisualConstraintsWithMetricsAndRatios(visualConstraints, items,
                                               metrics, ratios);
}
}
}

NSArray<NSLayoutConstraint*>* NDVisualConstraintWithOptionsWithMetricsAndRatios(
    NSDictionary<NSString*, NSNumber*>* visualConstraintWithOptions,
    NSDictionary<NSString*, id<NDNSLayoutConstraintItem>>* items,
    NSDictionary<NSString*, NSNumber*>* metrics,
    NSDictionary<NSString*, NSNumber*>* ratios) {
  auto guideItems =
      BuildExtendedGuideItems(visualConstraintWithOptions.allKeys, items);
  if (guideItems.count) {
    [guideItems addEntriesFromDictionary:items];
    items = guideItems;
  }

  auto layoutConstraints = [[NSMutableArray alloc] init];
  for (NSString* constraint in visualConstraintWithOptions.keyEnumerator) {
    auto options = visualConstraintWithOptions[constraint];
    [layoutConstraints
        addObjectsFromArray:
            [NSLayoutConstraint
                constraintsWithVisualFormat:constraint
                                    options:(NSLayoutFormatOptions)
                                                options.unsignedIntegerValue
                                    metrics:metrics
                                      views:items]];
  }

  [layoutConstraints addObjectsFromArray:NDConstraintRatios(ratios, items)];
  return [layoutConstraints copy];
}

NSArray<NSLayoutConstraint*>* NDVisualConstraintsWithMetricsAndRatios(
    NSArray<NSString*>* visualConstraints,
    NSDictionary<NSString*, id<NDNSLayoutConstraintItem>>* items,
    NSDictionary<NSString*, NSNumber*>* metrics,
    NSDictionary<NSString*, NSNumber*>* ratios) {
  auto guideItems = BuildExtendedGuideItems(visualConstraints, items);
  if (guideItems.count) {
    [guideItems addEntriesFromDictionary:items];
    items = guideItems;
  }

  auto layoutConstraints = [[NSMutableArray alloc] init];
  for (NSString* constraint in visualConstraints) {
    [layoutConstraints
        addObjectsFromArray:[NSLayoutConstraint
                                constraintsWithVisualFormat:constraint
                                                    options:kNilOptions
                                                    metrics:metrics
                                                      views:items]];
  }

  [layoutConstraints addObjectsFromArray:NDConstraintRatios(ratios, items)];

  return [layoutConstraints copy];
}

void NDApplyVisualConstraintWithOptionsWithMetricsAndRatios(
    NSDictionary<NSString*, NSNumber*>* visualConstraintWithOptions,
    NSDictionary<NSString*, id<NDNSLayoutConstraintItem>>* items,
    NSDictionary<NSString*, NSNumber*>* metrics,
    NSDictionary<NSString*, NSNumber*>* ratios) {
  [NSLayoutConstraint
      activateConstraints:NDVisualConstraintWithOptionsWithMetricsAndRatios(
                              visualConstraintWithOptions, items, metrics,
                              ratios)];
}

void NDApplyVisualConstraintsWithMetricsAndRatios(
    NSArray<NSString*>* visualConstraints,
    NSDictionary<NSString*, id<NDNSLayoutConstraintItem>>* items,
    NSDictionary<NSString*, NSNumber*>* metrics,
    NSDictionary<NSString*, NSNumber*>* ratios) {
  [NSLayoutConstraint
      activateConstraints:NDVisualConstraintsWithMetricsAndRatios(
                              visualConstraints, items, metrics, ratios)];
}
