//
//  UITableViewCell+NDAutolayoutUtils.mm
//  NDAutolayoutUtils
//
//  Created by Nguyen Duc Hiep on 10/5/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <NDAutolayoutUtils/UITableViewCell+NDAutolayoutUtils.h>

#import <NDAutolayoutUtils/UIView+NDAutolayoutUtils.h>

using namespace nd::autolayout;

@implementation UITableViewCell (NDAutolayoutUtils)

+ (instancetype)nd_wrapItems:
                    (NSDictionary<NSString*, id<NDNSLayoutConstraintItem>>*)
                        items
           visualConstraints:(NSArray<NSString*>*)visualConstraints
                  identifier:(NSString*)identifier {
  return Wrap<UITableViewCell*, UITableViewCellGetter>(
      items, visualConstraints, UITableViewCellCtor, self, identifier);
}

+ (instancetype)nd_wrapItem:(id<NDNSLayoutConstraintItem>)item
          visualConstraints:(NSArray<NSString*>*)visualConstraints
                 identifier:(NSString*)identifier {
  return [self nd_wrapItems:@{@"item" : item}
          visualConstraints:visualConstraints
                 identifier:identifier];
}

namespace {
inline UITableViewCell* UITableViewCellCtor(Class self, NSString* identifier) {
  return [[self alloc] initWithStyle:UITableViewCellStyleDefault
                     reuseIdentifier:identifier];
}

inline UIView* UITableViewCellGetter(UITableViewCell* self) {
  return self.contentView;
}
}

@end
