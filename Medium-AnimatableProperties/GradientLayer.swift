//
//  GradientLayer.swift
//  Medium-AnimatableProperties
//
//  Created by Kristóf Kálai on 01/01/2024.
//

import UIKit
import SwiftUI

final class GradientLayer: CAGradientLayer {
    @NSManaged var angleInDegrees: CGFloat
    var angleDidUpdate: ((Angle) -> Void)?

    override init(layer: Any) {
        super.init(layer: layer)
        if let layer = layer as? Self {
            angleInDegrees = layer.angleInDegrees
            angleDidUpdate = layer.angleDidUpdate
        }
    }

    override init() {
        super.init()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override class func needsDisplay(forKey key: String) -> Bool {
        key == #keyPath(angleInDegrees) ? true : super.needsDisplay(forKey: key)
    }

    override func action(forKey event: String) -> CAAction? {
        switch event {
        case #keyPath(angleInDegrees):
            let context = action(forKey: #keyPath(backgroundColor)) as? CABasicAnimation
            guard let animation = context?.copy() as? CABasicAnimation else { return nil }

            animation.keyPath = event
            animation.fromValue = presentation()?.value(forKeyPath: event)
            animation.toValue = nil
            return animation
        default:
            return super.action(forKey: event)
        }
    }

    override func draw(in ctx: CGContext) {
        super.draw(in: ctx)
        apply(degrees: currentLayer.angleInDegrees, on: model())
        angleDidUpdate?(.degrees(currentLayer.angleInDegrees))
    }
}
