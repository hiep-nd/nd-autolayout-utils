//
//  VisualConstraintUtils.m
//  NDAutolayoutUtils
//
//  Created by Nguyen Duc Hiep on 2/11/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <NDAutolayoutUtils/VisualConstraintUtils.h>

#import <NDAutolayoutUtils/ClassicalConstraintUtils.h>
#import <NDAutolayoutUtils/NSObject+NDAutolayoutUtils.h>
#import "Privates/NDContainerUtils.h"

#import <map>

using namespace nd;

void NDApplyVisualConstraints(NSArray<NSString*>* visualConstraints,
                              NSDictionary<NSString*, id>* views);
void NDApplyVisualConstraintsWithMetrics(
    NSArray<NSString*>* visualConstraints,
    NSDictionary<NSString*, id>* views,
    NSDictionary<NSString*, NSNumber*>* metrics);
void NDApplyVisualConstraintsWithMetricsAndRatios(
    NSArray<NSString*>* visualConstraints,
    NSDictionary<NSString*, id>* views,
    NSDictionary<NSString*, NSNumber*>* metrics,
    NSDictionary<NSString*, NSNumber*>* ratios);
void NDApplyVisualConstraintWithOptionsWithMetricsAndRatios(
    NSDictionary<NSString*, NSNumber*>* visualConstraintWithOptions,
    NSDictionary<NSString*, id>* views,
    NSDictionary<NSString*, NSNumber*>* metrics,
    NSDictionary<NSString*, NSNumber*>* ratios);
NSArray<NSLayoutConstraint*>* NDVisualConstraints(
    NSArray<NSString*>* visualConstraints,
    NSDictionary<NSString*, id>* views);
NSArray<NSLayoutConstraint*>* NDVisualConstraintsWithMetrics(
    NSArray<NSString*>* visualConstraints,
    NSDictionary<NSString*, id>* views,
    NSDictionary<NSString*, NSNumber*>* metrics);
NSArray<NSLayoutConstraint*>* NDVisualConstraintsWithMetricsAndRatios(
    NSArray<NSString*>* visualConstraints,
    NSDictionary<NSString*, id>* views,
    NSDictionary<NSString*, NSNumber*>* metrics,
    NSDictionary<NSString*, NSNumber*>* ratios);
NSArray<NSLayoutConstraint*>* NDVisualConstraintWithOptionsWithMetricsAndRatios(
    NSDictionary<NSString*, NSNumber*>* visualConstraintWithOptions,
    NSDictionary<NSString*, id>* views,
    NSDictionary<NSString*, NSNumber*>* metrics,
    NSDictionary<NSString*, NSNumber*>* ratios);

namespace nd {
void Apply(NSArray<NSString*>* visualConstraints,
           NSDictionary<NSString*, id>* views) {
  NDApplyVisualConstraints(visualConstraints, views);
}
}

void NDApplyVisualConstraints(NSArray<NSString*>* visualConstraints,
                              NSDictionary<NSString*, id>* views) {
  NDApplyVisualConstraintsWithMetrics(visualConstraints, views, nil);
}

namespace nd {
void Apply(NSArray<NSString*>* visualConstraints,
           NSDictionary<NSString*, id>* views,
           NSDictionary<NSString*, NSNumber*>* metrics) {
  NDApplyVisualConstraintsWithMetrics(visualConstraints, views, metrics);
}
}

void NDApplyVisualConstraintsWithMetrics(
    NSArray<NSString*>* visualConstraints,
    NSDictionary<NSString*, id>* views,
    NSDictionary<NSString*, NSNumber*>* metrics) {
  NDApplyVisualConstraintsWithMetricsAndRatios(visualConstraints, views,
                                               metrics, nil);
}

namespace nd {
void Apply(NSArray<NSString*>* visualConstraints,
           NSDictionary<NSString*, id>* views,
           NSDictionary<NSString*, NSNumber*>* metrics,
           NSDictionary<NSString*, NSNumber*>* ratios) {
  NDApplyVisualConstraintsWithMetricsAndRatios(visualConstraints, views,
                                               metrics, ratios);
}
}

void NDApplyVisualConstraintsWithMetricsAndRatios(
    NSArray<NSString*>* visualConstraints,
    NSDictionary<NSString*, id>* views,
    NSDictionary<NSString*, NSNumber*>* metrics,
    NSDictionary<NSString*, NSNumber*>* ratios) {
  [NSLayoutConstraint
      activateConstraints:NDVisualConstraintsWithMetricsAndRatios(
                              visualConstraints, views, metrics, ratios)];
}

namespace nd {
void Apply(NSDictionary<NSString*, NSNumber*>* visualConstraintWithOptions,
           NSDictionary<NSString*, id>* views,
           NSDictionary<NSString*, NSNumber*>* metrics,
           NSDictionary<NSString*, NSNumber*>* ratios) {
  NDApplyVisualConstraintWithOptionsWithMetricsAndRatios(
      visualConstraintWithOptions, views, metrics, ratios);
}
}

void NDApplyVisualConstraintWithOptionsWithMetricsAndRatios(
    NSDictionary<NSString*, NSNumber*>* visualConstraintWithOptions,
    NSDictionary<NSString*, id>* views,
    NSDictionary<NSString*, NSNumber*>* metrics,
    NSDictionary<NSString*, NSNumber*>* ratios) {
  [NSLayoutConstraint
      activateConstraints:NDVisualConstraintWithOptionsWithMetricsAndRatios(
                              visualConstraintWithOptions, views, metrics,
                              ratios)];
}

namespace nd {
NSArray<NSLayoutConstraint*>* Visual(NSArray<NSString*>* visualConstraints,
                                     NSDictionary<NSString*, id>* views) {
  return NDVisualConstraints(visualConstraints, views);
}
}

NSArray<NSLayoutConstraint*>* NDVisualConstraints(
    NSArray<NSString*>* visualConstraints,
    NSDictionary<NSString*, id>* views) {
  return NDVisualConstraintsWithMetrics(visualConstraints, views, nil);
}

namespace nd {
NSArray<NSLayoutConstraint*>* Visual(
    NSArray<NSString*>* visualConstraints,
    NSDictionary<NSString*, id>* views,
    NSDictionary<NSString*, NSNumber*>* metrics) {
  return NDVisualConstraintsWithMetrics(visualConstraints, views, metrics);
}
}

NSArray<NSLayoutConstraint*>* NDVisualConstraintsWithMetrics(
    NSArray<NSString*>* visualConstraints,
    NSDictionary<NSString*, id>* views,
    NSDictionary<NSString*, NSNumber*>* metrics) {
  return NDVisualConstraintsWithMetricsAndRatios(visualConstraints, views,
                                                 metrics, nil);
}

namespace nd {
NSArray<NSLayoutConstraint*>* Visual(
    NSArray<NSString*>* visualConstraints,
    NSDictionary<NSString*, id>* views,
    NSDictionary<NSString*, NSNumber*>* metrics,
    NSDictionary<NSString*, NSNumber*>* ratios) {
  return NDVisualConstraintsWithMetricsAndRatios(visualConstraints, views,
                                                 metrics, ratios);
}
}

namespace {
// clang-format off
inline NSMutableDictionary<NSString*, id>* BuildGuideViews(
    NSArray* visualConstraints,
    NSDictionary<NSString*, id>* views) {
  NSMutableDictionary* extendedViews = [[NSMutableDictionary alloc] init];
  [views enumerateKeysAndObjectsUsingBlock:^(NSString* name, NSObject* view,
                                             BOOL*) {
    static std::map<NSString*, UILayoutGuide* (^)(NSObject*)> guides({
      { @"leading", ^(NSObject* obj){ return obj.nd_leadingGuide; } },
      { @"trailing", ^(NSObject* obj){ return obj.nd_trailingGuide; } },
      { @"left", ^(NSObject* obj){ return obj.nd_leftGuide; } },
      { @"right", ^(NSObject* obj){ return obj.nd_rightGuide; } },
      { @"top", ^(NSObject* obj){ return obj.nd_topGuide; } },
      { @"bottom", ^(NSObject* obj){ return obj.nd_bottomGuide; } },
      { @"center", ^(NSObject* obj){ return obj.nd_centerGuide; } },
    });
    
    for (auto& i : guides) {
      auto guideName = [NSString stringWithFormat:@"%@_%@", name, i.first];
      if (Contain(visualConstraints, ^BOOL(NSString* c) {
            return [c containsString:guideName];
          })) {
        extendedViews[guideName] = i.second(view);
      }
    }
  }];

  return extendedViews;
}
// clang-format on
}

NSArray<NSLayoutConstraint*>* NDVisualConstraintsWithMetricsAndRatios(
    NSArray<NSString*>* visualConstraints,
    NSDictionary<NSString*, id>* views,
    NSDictionary<NSString*, NSNumber*>* metrics,
    NSDictionary<NSString*, NSNumber*>* ratios) {
  auto guideViews = BuildGuideViews(visualConstraints, views);
  if (guideViews.count) {
    [guideViews addEntriesFromDictionary:views];
    views = guideViews;
  }

  auto layoutConstraints = [[NSMutableArray alloc] init];
  for (NSString* constraint in visualConstraints) {
    [layoutConstraints
        addObjectsFromArray:[NSLayoutConstraint
                                constraintsWithVisualFormat:constraint
                                                    options:kNilOptions
                                                    metrics:metrics
                                                      views:views]];
  }

  [layoutConstraints addObjectsFromArray:NDConstraintRatios(ratios, views)];

  return [layoutConstraints copy];
}

namespace nd {
NSArray<NSLayoutConstraint*>* Visual(
    NSDictionary<NSString*, NSNumber*>* visualConstraintWithOptions,
    NSDictionary<NSString*, id>* views,
    NSDictionary<NSString*, NSNumber*>* metrics,
    NSDictionary<NSString*, NSNumber*>* ratios) {
  return NDVisualConstraintWithOptionsWithMetricsAndRatios(
      visualConstraintWithOptions, views, metrics, ratios);
}
}

NSArray<NSLayoutConstraint*>* NDVisualConstraintWithOptionsWithMetricsAndRatios(
    NSDictionary<NSString*, NSNumber*>* visualConstraintWithOptions,
    NSDictionary<NSString*, id>* views,
    NSDictionary<NSString*, NSNumber*>* metrics,
    NSDictionary<NSString*, NSNumber*>* ratios) {
  auto guideViews = BuildGuideViews(visualConstraintWithOptions.allKeys, views);
  if (guideViews.count) {
    [guideViews addEntriesFromDictionary:views];
    views = guideViews;
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
                                      views:views]];
  }

  [layoutConstraints addObjectsFromArray:NDConstraintRatios(ratios, views)];
  return [layoutConstraints copy];
}
