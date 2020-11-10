//
//  NDVisualConstraintUtils.swift
//  NDAutolayoutUtils
//
//  Created by Nguyen Duc Hiep on 2/25/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

import UIKit

/// Applies all |visualConstraints| with |metrics|, |ratios| to items  in |items|
@inlinable
public func nd_apply(
  visualConstraints: [String]? = nil,
  items: [String: NDNSLayoutConstraintItemProtocol],
  metrics: [String: CGFloat]? = nil,
  ratios: [String: CGFloat]? = nil
) {
  __NDApplyVisualConstraintsWithMetricsAndRatios(
    visualConstraints,
    items,
    metrics as [String: NSNumber]?,
    ratios as [String: NSNumber]?
  )
}

/// Applies all |visualConstraintWithOptions| with |metrics|, |ratios| to views
/// in |views|
@inlinable
public func nd_apply(
  visualConstraintWithOptions: [String: NSLayoutConstraint.FormatOptions]?,
  items: [String: NDNSLayoutConstraintItemProtocol],
  metrics: [String: CGFloat]? = nil,
  ratios: [String: CGFloat]? = nil
) {
  __NDApplyVisualConstraintWithOptionsWithMetricsAndRatios(
    visualConstraintWithOptions?.mapValues { NSNumber(value: $0.rawValue) },
    items,
    metrics as [String: NSNumber]?,
    ratios as [String: NSNumber]?
  )
}

/// Returns constraints based on the visual constraint with options described
/// with |constraints|, |metrics| and |ratios| to views in  |views|.
@inlinable
public func nd_visual(
  constraints: [String]? = nil,
  items: [String: NDNSLayoutConstraintItemProtocol],
  metrics: [String: CGFloat]? = nil,
  ratios: [String: CGFloat]? = nil
) -> [NSLayoutConstraint] {
  return __NDVisualConstraintsWithMetricsAndRatios(
    constraints,
    items,
    metrics as [String: NSNumber]?,
    ratios as [String: NSNumber]?
  )
}

/// Returns constraints based on the visual constraint with options described
/// with |constraintWithOptions|, |metrics| and |ratios| to views in  |views|.
@inlinable
public func nd_visual(
  constraintWithOptions: [String: NSLayoutConstraint.FormatOptions]? = nil,
  items: [String: NDNSLayoutConstraintItemProtocol],
  metrics: [String: CGFloat]? = nil,
  ratios: [String: CGFloat]? = nil
) -> [NSLayoutConstraint] {
  return __NDVisualConstraintWithOptionsWithMetricsAndRatios(
    constraintWithOptions?.mapValues { NSNumber(value: $0.rawValue) },
    items,
    metrics as [String: NSNumber]?,
    ratios as [String: NSNumber]?
  )
}
