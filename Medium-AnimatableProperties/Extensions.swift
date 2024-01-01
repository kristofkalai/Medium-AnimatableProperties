//
//  Extensions.swift
//  Medium-AnimatableProperties
//
//  Created by Kristóf Kálai on 01/01/2024.
//

import UIKit

extension CAGradientLayer {
    var location: [CGFloat]? {
        get {
            locations?.compactMap { CGFloat(exactly: $0) }
        }
        set {
            locations = newValue?.map { Double($0) }.map { NSNumber(value: $0) }
        }
    }

    var color: [UIColor]? {
        get {
            colors?.map { $0 as! CGColor }.compactMap { UIColor(cgColor: $0) }
        }
        set {
            colors = newValue?.map(\.cgColor)
        }
    }

    private func calculatePoints(degrees angle: CGFloat) -> (startPoint: CGPoint, endPoint: CGPoint) {
        let x = angle / 360
        let a = pow(sinf(Float(2 * .pi * ((x + 0.75) / 2))), 2)
        let b = pow(sinf(Float(2 * .pi * ((x + 0.00) / 2))), 2)
        let c = pow(sinf(Float(2 * .pi * ((x + 0.25) / 2))), 2)
        let d = pow(sinf(Float(2 * .pi * ((x + 0.50) / 2))), 2)

        return (CGPoint(x: CGFloat(a), y: CGFloat(b)), CGPoint(x: CGFloat(c), y: CGFloat(d)))
    }

    func apply(degrees angle: CGFloat /* .zero means top to bottom gradient */, on layer: CAGradientLayer? = nil) {
        let (startPoint, endPoint) = calculatePoints(degrees: angle)

        (layer ?? self).endPoint = endPoint
        (layer ?? self).startPoint = startPoint
    }
}

extension CALayer {
    var currentLayer: Self {
        presentation() ?? self
    }
}
