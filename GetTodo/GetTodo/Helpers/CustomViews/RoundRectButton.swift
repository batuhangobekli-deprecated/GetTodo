//
//  RoundedButton.swift
//  GetTodo
//
//  Created by Batuhan Göbekli on 23.11.2020.
//  Copyright © 2020 Batuhan Göbekli. All rights reserved.
//

import UIKit

/// UIButton subclass that draws a rounded rectangle in its background.
public class RoundRectButton: UIButton {

    // MARK: Public interface
    /// Corner radius of the background rectangle
    public var roundRectCornerRadius: CGFloat = 20 {
        didSet {
            self.setNeedsLayout()
        }
    }

    /// Color of the background rectangle
    public var roundRectColor: UIColor = UIColor(hexString: "#8655EA") {
        didSet {
            self.setNeedsLayout()
        }
    }

    // MARK: Overrides
    override public func layoutSubviews() {
        super.layoutSubviews()
        layoutRoundRectLayer()
    }

    // MARK: Private
    private var roundRectLayer: CAShapeLayer?

    private func layoutRoundRectLayer() {
        if let existingLayer = roundRectLayer {
            existingLayer.removeFromSuperlayer()
        }
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: roundRectCornerRadius).cgPath
        shapeLayer.fillColor = roundRectColor.cgColor
        self.layer.insertSublayer(shapeLayer, at: 0)
        self.roundRectLayer = shapeLayer
    }
}
