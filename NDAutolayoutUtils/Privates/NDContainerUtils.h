//
//  NDContainerUtils.h
//  NDAutolayoutUtils
//
//  Created by Nguyen Duc Hiep on 3/4/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

namespace nd {
inline BOOL Contain(id<NSFastEnumeration> container, BOOL (^conditioner)(id)) {
  if (!conditioner) {
    return NO;
  }

  for (__unsafe_unretained id obj in container) {
    if (conditioner(obj)) {
      return YES;
    }
  }
  return NO;
}
}

NS_ASSUME_NONNULL_END
