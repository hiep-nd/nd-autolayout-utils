//
//  NDCommonLayoutGuidesContainerUtils.h
//  NDAutolayoutUtils
//
//  Created by Nguyen Duc Hiep on 7/15/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <NDAutolayoutUtils/NDCommonLayoutGuidesContainer.h>

#import <objc/runtime.h>
#import <vector>

NS_ASSUME_NONNULL_BEGIN

namespace nd {
namespace NDCommonLayoutGuidesContainer {
static std::vector<SEL> const kGuideKeys = {
    @selector(nd_leadingGuide), @selector(nd_trailingGuide),
    @selector(nd_leftGuide),    @selector(nd_rightGuide),
    @selector(nd_topGuide),     @selector(nd_bottomGuide),
    @selector(nd_centerGuide),
};
}

inline UILayoutGuide* PeekLayoutGuide(id self, const void* key) {
  return objc_getAssociatedObject(self, key);
}

inline void SetLayoutGuide(id self, const void* key, UILayoutGuide* guide) {
  objc_setAssociatedObject(self, key, guide, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

inline void SetOwnerView(UIView* oldOwnerView,
                         UIView* ownerView,
                         UILayoutGuide* layoutGuide) {
  if (oldOwnerView != ownerView) {
    for (auto& key : NDCommonLayoutGuidesContainer::kGuideKeys) {
      auto guide = PeekLayoutGuide(layoutGuide, key);
      if (guide) {
        [ownerView addLayoutGuide:guide];
      }
    }
  }
}

inline void ResetOwnerView(UIView* oldOwnerView, UILayoutGuide* layoutGuide) {
  if (oldOwnerView != nil) {
    for (auto& key : NDCommonLayoutGuidesContainer::kGuideKeys) {
      auto guide = PeekLayoutGuide(layoutGuide, key);
      if (guide) {
        [oldOwnerView removeLayoutGuide:guide];
      }
    }
  }
}

inline void SwizzleMethods(Class cls,
                           const std::vector<std::tuple<SEL, SEL>>& sels) {
  for (auto& sel : sels) {
    auto originalMethod = class_getInstanceMethod(cls, std::get<0>(sel));
    auto swizzledMethod = class_getInstanceMethod(cls, std::get<1>(sel));
    BOOL didAddMethod = class_addMethod(
        cls, std::get<0>(sel), method_getImplementation(swizzledMethod),
        method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
      class_replaceMethod(cls, std::get<1>(sel),
                          method_getImplementation(originalMethod),
                          method_getTypeEncoding(originalMethod));
    } else {
      method_exchangeImplementations(originalMethod, swizzledMethod);
    }
  }
}

inline NSLayoutConstraint* Anchor(id item1,
                                  id item2,
                                  NSLayoutAttribute attr1,
                                  NSLayoutAttribute attr2) {
  return [NSLayoutConstraint constraintWithItem:item1
                                      attribute:attr1
                                      relatedBy:NSLayoutRelationEqual
                                         toItem:item2
                                      attribute:attr2
                                     multiplier:1
                                       constant:0];
}

inline UIView* GetLayoutGuidesContainerView(UILayoutGuide* obj) {
  return obj.owningView;
}

inline UIView* GetLayoutGuidesContainerView(UIView* obj) {
  return obj;
}

template <typename T>
inline UILayoutGuide* GetGuide(T* _Nonnull obj,
                               const void* key,
                               NSLayoutAttribute attrG1,
                               NSLayoutAttribute attrO1,
                               NSLayoutAttribute attrG2,
                               NSLayoutAttribute attrO2,
                               NSLayoutAttribute attrG3,
                               NSLayoutAttribute attrO3,
                               NSLayoutAttribute attrG4,
                               NSLayoutAttribute attrO4) {
  auto guide = PeekLayoutGuide(obj, key);
  if (!guide) {
    guide = [[UILayoutGuide alloc] init];
    [GetLayoutGuidesContainerView(obj) addLayoutGuide:guide];
    [NSLayoutConstraint activateConstraints:@[
      Anchor(guide, obj, attrG1, attrO1),
      Anchor(guide, obj, attrG2, attrO2),
      Anchor(guide, obj, attrG3, attrO3),
      Anchor(guide, obj, attrG4, attrO4),
    ]];

    SetLayoutGuide(obj, key, guide);
  }

  return guide;
}
}

#define NDCommonLayoutGuidesContainer_Default_Impl                             \
  -(UILayoutGuide*)nd_leadingGuide {                                           \
    return nd::GetGuide(self, @selector(nd_leadingGuide),                      \
                        NSLayoutAttributeTop, NSLayoutAttributeTop,            \
                        NSLayoutAttributeBottom, NSLayoutAttributeBottom,      \
                        NSLayoutAttributeLeading, NSLayoutAttributeLeading,    \
                        NSLayoutAttributeTrailing, NSLayoutAttributeLeading);  \
  }                                                                            \
                                                                               \
  -(UILayoutGuide*)nd_trailingGuide {                                          \
    return nd::GetGuide(self, @selector(nd_trailingGuide),                     \
                        NSLayoutAttributeTop, NSLayoutAttributeTop,            \
                        NSLayoutAttributeBottom, NSLayoutAttributeBottom,      \
                        NSLayoutAttributeLeading, NSLayoutAttributeTrailing,   \
                        NSLayoutAttributeTrailing, NSLayoutAttributeTrailing); \
  }                                                                            \
                                                                               \
  -(UILayoutGuide*)nd_leftGuide {                                              \
    return nd::GetGuide(self, @selector(nd_leftGuide), NSLayoutAttributeTop,   \
                        NSLayoutAttributeTop, NSLayoutAttributeBottom,         \
                        NSLayoutAttributeBottom, NSLayoutAttributeLeft,        \
                        NSLayoutAttributeLeft, NSLayoutAttributeRight,         \
                        NSLayoutAttributeLeft);                                \
  }                                                                            \
                                                                               \
  -(UILayoutGuide*)nd_rightGuide {                                             \
    return nd::GetGuide(self, @selector(nd_rightGuide), NSLayoutAttributeTop,  \
                        NSLayoutAttributeTop, NSLayoutAttributeBottom,         \
                        NSLayoutAttributeBottom, NSLayoutAttributeLeft,        \
                        NSLayoutAttributeRight, NSLayoutAttributeRight,        \
                        NSLayoutAttributeRight);                               \
  }                                                                            \
                                                                               \
  -(UILayoutGuide*)nd_topGuide {                                               \
    return nd::GetGuide(self, @selector(nd_topGuide), NSLayoutAttributeTop,    \
                        NSLayoutAttributeTop, NSLayoutAttributeBottom,         \
                        NSLayoutAttributeTop, NSLayoutAttributeLeft,           \
                        NSLayoutAttributeLeft, NSLayoutAttributeRight,         \
                        NSLayoutAttributeRight);                               \
  }                                                                            \
                                                                               \
  -(UILayoutGuide*)nd_bottomGuide {                                            \
    return nd::GetGuide(self, @selector(nd_bottomGuide), NSLayoutAttributeTop, \
                        NSLayoutAttributeBottom, NSLayoutAttributeBottom,      \
                        NSLayoutAttributeBottom, NSLayoutAttributeLeft,        \
                        NSLayoutAttributeLeft, NSLayoutAttributeRight,         \
                        NSLayoutAttributeRight);                               \
  }                                                                            \
                                                                               \
  -(UILayoutGuide*)nd_centerGuide {                                            \
    return nd::GetGuide(self, @selector(nd_centerGuide), NSLayoutAttributeTop, \
                        NSLayoutAttributeCenterY, NSLayoutAttributeBottom,     \
                        NSLayoutAttributeCenterY, NSLayoutAttributeLeft,       \
                        NSLayoutAttributeCenterX, NSLayoutAttributeRight,      \
                        NSLayoutAttributeCenterX);                             \
  }

NS_ASSUME_NONNULL_END
