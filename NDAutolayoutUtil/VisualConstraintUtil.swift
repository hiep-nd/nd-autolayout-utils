//
//  VisualConstraintUtil.swift
//  NDAutolayoutUtil
//
//  Created by Nguyen Duc Hiep on 2/25/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

import UIKit

/// Applies all |visualConstraints| with |metrics|, |ratios| to views  in |views|
public func apply(
  visualConstraints: [String]? = nil,
  views: [String: Any],
  metrics: [String: CGFloat]? = nil,
  ratios: [String: CGFloat]? = nil
) {
  __NDApplyVisualConstraintsWithMetricsAndRatios(
    visualConstraints, views, metrics as [String: NSNumber]?,
    ratios as [String: NSNumber]?)
}

/// Applies all |visualConstraintWithOptions| with |metrics|, |ratios| to views
/// in |views|
public func apply(
  visualConstraintWithOptions: [String: NSLayoutConstraint.FormatOptions]?,
  views: [String: Any],
  metrics: [String: CGFloat]? = nil,
  ratios: [String: CGFloat]? = nil
) {
  __NDApplyVisualConstraintWithOptionsWithMetricsAndRatios(
    visualConstraintWithOptions?.mapValues { NSNumber(value: $0.rawValue) },
    views, metrics as [String: NSNumber]?,
    ratios as [String: NSNumber]?)
}

/// Returns constraints based on the visual constraint with options described
/// with |constraints|, |metrics| and |ratios| to views in  |views|.
public func visual(
  constraints: [String]? = nil,
  views: [String: Any],
  metrics: [String: CGFloat]? = nil,
  ratios: [String: CGFloat]? = nil
) -> [NSLayoutConstraint] {

  return __NDVisualConstraintsWithMetricsAndRatios(
    constraints, views,
    metrics as [String: NSNumber]?,
    ratios as [String: NSNumber]?)
}

/// Returns constraints based on the visual constraint with options described
/// with |constraintWithOptions|, |metrics| and |ratios| to views in  |views|.
public func visual(
  constraintWithOptions: [String: NSLayoutConstraint.FormatOptions]? = nil,
  views: [String: Any],
  metrics: [String: CGFloat]? = nil,
  ratios: [String: CGFloat]? = nil
) -> [NSLayoutConstraint] {

  return __NDVisualConstraintWithOptionsWithMetricsAndRatios(
    constraintWithOptions?.mapValues { NSNumber(value: $0.rawValue) }, views,
    metrics as [String: NSNumber]?,
    ratios as [String: NSNumber]?)
}
