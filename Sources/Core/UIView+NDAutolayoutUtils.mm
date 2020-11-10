//
//  UIView+NDAutolayoutUtils.mm
//  NDAutolayoutUtils
//
//  Created by Nguyen Duc Hiep on 7/15/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <NDAutolayoutUtils/UIView+NDAutolayoutUtils.h>

#import <NDAutolayoutUtils/NDVisualConstraintUtils.h>
#import <NDLog/NDLog.h>

using namespace nd;
using namespace nd::autolayout;

@implementation UIView (NDAutolayoutUtils)

- (void)nd_addSubviews:(NSArray<UIView*>*)views {
  [self nd_addSubviews:views translatesAutoresizingMaskIntoConstraints:@(NO)];
}

- (void)nd_addSubviews:(NSArray<UIView*>*)views
    translatesAutoresizingMaskIntoConstraints:
        (NSNumber*)translatesAutoresizingMaskIntoConstraints {
  if (translatesAutoresizingMaskIntoConstraints != nil) {
    auto translates = translatesAutoresizingMaskIntoConstraints.boolValue;
    for (UIView* v in views) {
      v.translatesAutoresizingMaskIntoConstraints = translates;
      [self addSubview:v];
    }
  } else {
    for (UIView* v in views) {
      [self addSubview:v];
    }
  }
}

- (void)nd_addLayoutGuides:(NSArray<UILayoutGuide*>*)layoutGuides {
  [layoutGuides
      enumerateObjectsUsingBlock:^(UILayoutGuide* obj, NSUInteger, BOOL*) {
        [self addLayoutGuide:obj];
      }];
}

- (void)nd_addLayoutConstraintItems:
    (NSArray<id<NDNSLayoutConstraintItem>>*)items {
  [items enumerateObjectsUsingBlock:^(id<NDNSLayoutConstraintItem> obj,
                                      NSUInteger, BOOL*) {
    [obj nd_addToContainerView:self];
  }];
}

- (void)nd_addLayoutConstraintItems:
            (NSArray<id<NDNSLayoutConstraintItem>>*)items
    translatesAutoresizingMaskIntoConstraints:
        (NSNumber* _Nullable)translatesAutoresizingMaskIntoConstraints {
  [items enumerateObjectsUsingBlock:^(id<NDNSLayoutConstraintItem> obj,
                                      NSUInteger, BOOL*) {
    [obj nd_addToContainerView:self
        translatesAutoresizingMaskIntoConstraints:
            translatesAutoresizingMaskIntoConstraints];
  }];
}

- (void)nd_fillWithContentView:(UIView*)contentView {
  AddAndAnchor(self, self, contentView);
}

- (void)nd_fillMarginWithContentView:(UIView*)contentView {
  AddAndAnchor(self, self.layoutMarginsGuide, contentView);
}

namespace {
template <typename T>
inline void AddAndAnchor(UIView* container, T* anchor, UIView* contentView) {
  if (!contentView) {
    NDCAssertionFailure(@"Can not fill view: '%@' with content view: '%@'.",
                        container, contentView);
    return;
  }

  [container nd_addSubviews:@[ contentView ]];
  [NSLayoutConstraint activateConstraints:@[
    [anchor.topAnchor constraintEqualToAnchor:contentView.topAnchor],
    [anchor.bottomAnchor constraintEqualToAnchor:contentView.bottomAnchor],
    [anchor.leftAnchor constraintEqualToAnchor:contentView.leftAnchor],
    [anchor.rightAnchor constraintEqualToAnchor:contentView.rightAnchor],
  ]];
}
}

+ (instancetype)nd_wrapItems:
                    (NSDictionary<NSString*, id<NDNSLayoutConstraintItem>>*)
                        items
           visualConstraints:(NSArray<NSString*>*)visualConstraints {
  return Wrap<UIView*>(items, visualConstraints, WrapUIViewCtor, self);
}

+ (instancetype)nd_wrapItem:(id<NDNSLayoutConstraintItem>)item
          visualConstraints:(NSArray<NSString*>*)visualConstraints {
  return [self nd_wrapItems:@{@"item" : item}
          visualConstraints:visualConstraints];
}

- (instancetype)nd_wrapItems:
                    (NSDictionary<NSString*, id<NDNSLayoutConstraintItem>>*)
                        items
           visualConstraints:(NSArray<NSString*>*)visualConstraints {
  [items enumerateKeysAndObjectsUsingBlock:^(
             NSString*, id<NDNSLayoutConstraintItem> obj, BOOL*) {
    if (!obj.nd_containerView) {
      [obj nd_addToContainerView:self];
    }
  }];

  NSMutableDictionary* extendeds = nil;
  if (!items[@"safeArea"]) {
    if (@available(iOS 11, *)) {
      Extend(extendeds, @"safeArea", self.safeAreaLayoutGuide);
    } else {
      Extend(extendeds, @"safeArea", self);
    }
  }

  if (!items[@"wrapper"]) {
    Extend(extendeds, @"wrapper", self);
  }

  if (extendeds) {
    [extendeds addEntriesFromDictionary:items];
    items = extendeds;
  }

  Apply(visualConstraints, items);

  return self;
}

- (instancetype)nd_wrapItem:(id<NDNSLayoutConstraintItem>)item
          visualConstraints:(NSArray<NSString*>*)visualConstraints {
  return [self nd_wrapItems:@{@"item" : item}
          visualConstraints:visualConstraints];
}

namespace {
inline void Extend(__strong NSMutableDictionary*& extendeds,
                   id<NSCopying> key,
                   NSObject* obj) {
  if (extendeds) {
    extendeds[key] = obj;
  } else {
    extendeds =
        [[NSMutableDictionary alloc] initWithObjectsAndKeys:obj, key, nil];
  }
}

inline UIView* WrapUIViewCtor(Class self) {
  return [[self alloc] init];
}
}

@end
