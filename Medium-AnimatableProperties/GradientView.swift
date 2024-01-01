//
//  GradientView.swift
//  Medium-AnimatableProperties
//
//  Created by Kristóf Kálai on 01/01/2024.
//

import UIKit
import SwiftUI

final class GradientView: UIView {
    var colors: [UIColor]? {
        get {
            layer.color
        }
        set {
            layer.color = newValue
        }
    }

    var locations: [CGFloat]? {
        get {
            layer.location
        }
        set {
            layer.location = newValue
        }
    }

    var angle: Angle /* .zero means top to bottom gradient */ {
        get {
            .init(degrees: layer.angleInDegrees)
        }
        set {
            layer.angleInDegrees = .init(newValue.degrees)
        }
    }

    var angleDidUpdate: ((Angle) -> Void)? {
        get {
            layer.angleDidUpdate
        }
        set {
            layer.angleDidUpdate = newValue
        }
    }

    override class var layerClass: AnyClass {
        GradientLayer.self
    }

    override var layer: GradientLayer {
        super.layer as! GradientLayer
    }

    init(frame: CGRect = .zero, colors: [UIColor]? = nil, locations: [CGFloat]? = nil, angle: Angle = .zero, angleDidUpdate: ((Angle) -> Void)? = nil) {
        super.init(frame: frame)
        self.colors = colors
        self.locations = locations
        self.angle = angle
        self.angleDidUpdate = angleDidUpdate
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
