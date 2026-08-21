//
//  Extension+UIView.swift
//  SyriabookingAdmin
//
//  Created by Hitman on 13/07/26.
//

import Foundation
import UIKit

extension UIView {
    
    @IBInspectable var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
    @IBInspectable var borderColor: UIColor {
        get { return UIColor(cgColor: layer.borderColor ?? UIColor.clear.cgColor) }
        set { layer.borderColor = newValue.cgColor }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    func applyShadow(color: UIColor = .black,alpha: Float = 0.2,x: CGFloat = 0,y: CGFloat = 2,blur: CGFloat = 6,spread: CGFloat = 0) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = alpha
        layer.shadowOffset = CGSize(width: x, height: y)
        layer.shadowRadius = blur / 2.0
        
        if spread == 0 {
            layer.shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            layer.shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
    
    func applyLightShadow(color: UIColor = .lightGray,alpha: Float = 0.5,x: CGFloat = 0,y: CGFloat = 1,blur: CGFloat = 4) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = alpha
        layer.shadowOffset = CGSize(width: x, height: y)
        layer.shadowRadius = blur / 2
        layer.shadowPath = nil
    }
    
    func applyOverviewGradient() {
        layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
        
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.name = "overviewGradient"
        
        gradient.colors = [
            UIColor(hex: "#379D67").cgColor,
            UIColor(hex: "#22C55E").cgColor
        ]
        
        
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        gradient.cornerRadius = layer.cornerRadius
        layer.insertSublayer(gradient, at: 0)
    }
    
    func addDashedBorder() {
            layer.sublayers?
            .filter { $0.name == "DashedBorderLayer" }
            .forEach { $0.removeFromSuperlayer() }
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.name = "DashedBorderLayer"
        shapeLayer.strokeColor = UIColor.systemGray3.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineDashPattern = [6, 4]
        shapeLayer.frame = bounds
        shapeLayer.path = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: 16
        ).cgPath
        
        layer.addSublayer(shapeLayer)
    }
    
}

