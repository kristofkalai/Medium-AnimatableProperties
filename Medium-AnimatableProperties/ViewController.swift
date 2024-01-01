//
//  ViewController.swift
//  Medium-AnimatableProperties
//
//  Created by Kristóf Kálai on 01/01/2024.
//

import UIKit

final class ViewController: UIViewController {
    private let subview: GradientView = {
        let view = GradientView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blue
        view.heightAnchor.constraint(equalToConstant: 100).isActive = true
        view.widthAnchor.constraint(equalToConstant: 100).isActive = true
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(subview)
        subview.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        subview.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        subview.colors = [.red, .green]
        subview.angle = .zero

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.animate()
        }
    }

    private func animate() {
        UIView.animate(withDuration: 3) {
            self.subview.angle = .degrees(270)
        }
    }
}
