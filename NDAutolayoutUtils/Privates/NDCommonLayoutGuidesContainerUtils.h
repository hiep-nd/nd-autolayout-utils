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

template <typename T>
inline T PeekProperty(id self, const void* key) {
  return objc_getAssociatedObject(self, key);
}

inline UILayoutGuide* PeekLayoutGuide(id self, const void* key) {
  return PeekProperty<UILayoutGuide*>(self, key);
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

/*
inline void SwizzleLayoutContainerViewGetter() {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    static std::vector<tuple<SEL, SEL>> sels = {
      std::make_tuple(@selector(addLayoutGuide:),
@selector(nd_swizzled_addLayoutGuide:)),
      std::make_tuple(@selector(removeLayoutGuide:),
@selector(nd_swizzled_removeLayoutGuide:)),
      std::make_tuple(@selector(removeFromSuperview),
@selector(nd_swizzled_removeFromSuperview)),
      std::make_tuple(@selector(insertSubview:atIndex:),
@selector(nd_swizzled_insertSubview:atIndex:)),
      std::make_tuple(@selector(addSubview:),
@selector(nd_swizzled_addSubview:)),
      std::make_tuple(@selector(insertSubview:belowSubview:),
@selector(nd_swizzled_insertSubview:belowSubview:)),
      std::make_tuple(@selector(insertSubview:aboveSubview:),
@selector(nd_swizzled_insertSubview:aboveSubview:)),
    };

    auto cls = [UIView class];
    for (auto& sel: sels) {
      auto originalMethod = class_getInstanceMethod(cls, get<0>(sel));
      auto swizzledMethod = class_getInstanceMethod(cls, get<1>(sel));
      BOOL didAddMethod =
          class_addMethod(cls,
                          get<0>(sel),
              method_getImplementation(swizzledMethod),
              method_getTypeEncoding(swizzledMethod));
      if (didAddMethod) {
          class_replaceMethod(cls,
              get<1>(sel),
              method_getImplementation(originalMethod),
              method_getTypeEncoding(originalMethod));
      } else {
          method_exchangeImplementations(originalMethod, swizzledMethod);
      }
    }
  });
}
*/

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

inline NSLayoutConstraint* Anchor(id item1,
                                  id item2,
                                  NSLayoutAttribute attr1,
                                  NSLayoutAttribute attr2,
                                  CGFloat constant) {
  return [NSLayoutConstraint constraintWithItem:item1
                                      attribute:attr1
                                      relatedBy:NSLayoutRelationEqual
                                         toItem:item2
                                      attribute:attr2
                                     multiplier:1
                                       constant:constant];
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

template <typename T>
inline void CreatePaddingObjects(T* _Nonnull obj) {
  auto guide = [[UILayoutGuide alloc] init];
  [GetLayoutGuidesContainerView(obj) addLayoutGuide:guide];
  
  auto topConstraint = Anchor(obj, guide, NSLayoutAttributeTop, NSLayoutAttributeTop)
  auto bottomConstraint = Anchor(obj, guide, NSLayoutAttributeBottom, NSLayoutAttributeBottom)
  auto leftConstraint = Anchor(obj, guide, NSLayoutAttributeLeft, NSLayoutAttributeTop)
  auto rightConstraint = Anchor(obj, guide, NSLayoutAttributeTop, NSLayoutAttributeTop)
  
  Anchor(guide, obj, attrG1, attrO1)
  
  [NSLayoutConstraint activateConstraints:@[
    Anchor(guide, obj, attrG1, attrO1),
    Anchor(guide, obj, attrG2, attrO2),
    Anchor(guide, obj, attrG3, attrO3),
    Anchor(guide, obj, attrG4, attrO4),
  ]];

  SetLayoutGuide(obj, key, guide);
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

- (NSLayoutConstraint *)nd_paddingTopConstraint {
  return PeekProperty<NSLayoutConstraint *>(self, @selector(nd_paddingTopConstraint));
}

- (NSLayoutConstraint *)nd_paddingLeftConstraint {
  return PeekProperty<NSLayoutConstraint *>(self, @selector(nd_paddingLeftConstraint));
}

- (NSLayoutConstraint *)nd_paddingBottomConstraint {
  return PeekProperty<NSLayoutConstraint *>(self, @selector(nd_paddingBottomConstraint));
}

- (NSLayoutConstraint *)nd_paddingRightConstraint {
  return PeekProperty<NSLayoutConstraint *>(self, @selector(nd_paddingRightConstraint));
}

- (UIEdgeInsets)nd_padding {
  auto topConstraint = self.nd_paddingTopConstraint;
  if (!topConstraint) {
    [sel]
  }
  
  return UIEdgeInsetsMake(self.nd_paddingTopConstraint.constant, self.nd_paddingLeftConstraint.constant, self.nd_paddingBottomConstraint.constant, self.nd_paddingRightConstraint.constant);
}

- (void)setNd_padding:(UIEdgeInsets)nd_padding {
  
}

- (UILayoutGuide *)nd_paddingGuide {
  auto guide = PeekLayoutGuide(obj, @selector(nd_paddingGuide));
  if (!guide) {
    guide = [[UILayoutGuide alloc] init];
    [GetLayoutGuidesContainerView(obj) addLayoutGuide:guide];
    Anchor(guide, obj, attrG1, attrO1)
    
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

@property(nonatomic, assign) UIEdgeInsets nd_padding;
@property(nonatomic, strong, readonly) UILayoutGuide* nd_paddingGuide;


NS_ASSUME_NONNULL_END
