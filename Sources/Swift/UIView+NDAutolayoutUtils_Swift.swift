//
//  UIView+NDAutolayoutUtils_Swift.swift
//  NDManualObjects
//
//  Created by Nguyen Duc Hiep on 2/13/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

extension UIView {
  @inlinable
  public func nd_add(
    subviews: [UIView],
    translatesAutoresizingMaskIntoConstraints translates: Bool?
  ) {
    __nd_addSubviews(
      subviews,
      translatesAutoresizingMaskIntoConstraints: translates.map { NSNumber(value: $0) }
    )
  }

  @inlinable
  public func nd_add(
    items: [NDNSLayoutConstraintItemProtocol],
    translatesAutoresizingMaskIntoConstraints translates: Bool?
  ) {
    __nd_add(
      items,
      translatesAutoresizingMaskIntoConstraints: translates.map { NSNumber(value: $0) }
    )
  }
}
