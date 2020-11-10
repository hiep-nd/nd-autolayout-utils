//
//  UITableViewCell+NDAutolayoutUtils.h
//  NDAutolayoutUtils
//
//  Created by Nguyen Duc Hiep on 10/5/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <NDAutolayoutUtils/NDNSLayoutConstraintItem.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableViewCell (NDAutolayoutUtils)

+ (instancetype)nd_wrapItems:
                    (NSDictionary<NSString*, id<NDNSLayoutConstraintItem>>*)
                        items
           visualConstraints:(NSArray<NSString*>*)visualConstraints
                  identifier:(NSString* _Nullable)identifier
    NS_SWIFT_NAME(nd_wrap(items:visualConstraints:identifier:));

+ (instancetype)nd_wrapItem:(id<NDNSLayoutConstraintItem>)item
          visualConstraints:(NSArray<NSString*>*)visualConstraints
                 identifier:(NSString* _Nullable)identifier
    NS_SWIFT_NAME(nd_wrap(item:visualConstraints:identifier:));

@end

NS_ASSUME_NONNULL_END
