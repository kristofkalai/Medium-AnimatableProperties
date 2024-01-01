//
//  TextLabel.swift
//  Medium-AnimatableProperties
//
//  Created by Kristóf Kálai on 01/01/2024.
//

import UIKit

final class TextLabel: UIView {
    final private class TextLayer: CATextLayer {
        override func action(forKey event: String) -> CAAction? {
            switch event {
            case #keyPath(foregroundColor): // 0
                let context = action(forKey: #keyPath(backgroundColor)) as? CABasicAnimation // 1
                guard let animation = context?.copy() as? CABasicAnimation else { return nil } // 2

                animation.keyPath = event
                animation.fromValue = presentation()?.value(forKeyPath: event) // 3
                animation.toValue = nil
                return animation
            default:
                return super.action(forKey: event)
            }
        }
    }

    enum Text {
        case string(String)
        case attributedString(NSAttributedString)
        case none
    }

    var text: Text {
        get {
            if let attributedString = layer.string as? NSAttributedString {
                .attributedString(attributedString)
            } else if let string = layer.string as? String {
                .string(string)
            } else {
                .none
            }
        }
        set {
            switch newValue {
            case let .string(string): layer.string = string
            case let .attributedString(attributedString): layer.string = attributedString
            case .none: layer.string = nil
            }
        }
    }

    var font: UIFont? {
        get {
            func cast(_ cfString: CFString?) -> String? {
                if let cfString {
                    cfString as NSString as String
                } else {
                    nil
                }
            }

            let name: String? = {
                switch layer.font {
                case let ctFont as CTFont: cast(CTFontCopyName(ctFont, kCTFontPostScriptNameKey))
                case let cgFont as CGFont: cast(cgFont.postScriptName)
                case let string as NSString: string as String
                case let string as String: string
                default: nil
                }
            }()

            return name.flatMap { UIFont(name: $0, size: layer.fontSize) }
        }
        set {
            layer.font = newValue
        }
    }

    var fontSize: CGFloat {
        get {
            layer.fontSize
        }
        set {
            layer.fontSize = newValue
        }
    }

    var foregroundColor: UIColor? {
        get {
            layer.foregroundColor.map { .init(cgColor: $0) }
        }
        set {
            layer.foregroundColor = newValue?.cgColor
        }
    }

    var isWrapped: Bool {
        get {
            layer.isWrapped
        }
        set {
            layer.isWrapped = newValue
        }
    }

    var truncationMode: CATextLayerTruncationMode {
        get {
            layer.truncationMode
        }
        set {
            layer.truncationMode = newValue
        }
    }

    var alignmentMode: CATextLayerAlignmentMode {
        get {
            layer.alignmentMode
        }
        set {
            layer.alignmentMode = newValue
        }
    }

    var allowsFontSubpixelQuantization: Bool {
        get {
            layer.allowsFontSubpixelQuantization
        }
        set {
            layer.allowsFontSubpixelQuantization = newValue
        }
    }

    override class var layerClass: AnyClass {
        TextLayer.self
    }

    override var layer: CATextLayer {
        super.layer as! CATextLayer
    }

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
}

extension TextLabel {
    private func commonInit() {
        layer.contentsScale = UIScreen.main.scale
    }
}
