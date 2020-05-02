//
//  CALayer+CircleProgress.swift
//  TimePlannerApp
//
//  Created by Mazurov, Aleksandr on 5/2/20.
//  Copyright © 2020 AlexandrMazurov. All rights reserved.
//

import UIKit

private enum Constants {
    static let circleLayerName = "circle.progress.layer"
    static let progressLayerName = "progress.line.layer"
    static let halfElementSizeDivider: CGFloat = 2
    static let shadowOpacity: Float = 1
    static let circlePIFactor: CGFloat = 1.5
    static let circleLayerLineColor: CGColor = UIColor.gray.cgColor
    static let circleLayerOpacity: Float = 0.5
    static let circleLayerShadowRadius: CGFloat = 1
    static let progressLayerShadowRadius: CGFloat = 0.5
    static let progressLayerCornerRadius: CGFloat = 3
}

extension CALayer {

    func configureCircleProgress(progress value: Double, lineWidth: CGFloat, color: CGColor) {
        setupCircleLayer(lineWidth: lineWidth)
        setupCompletedLayer(to: value, lineWidth: lineWidth, color: color)
    }

    private func setupCircleLayer(lineWidth: CGFloat) {
        let circleLayer = CAShapeLayer()
        circleLayer.name = Constants.circleLayerName
        removeOldSublayer(name: Constants.circleLayerName)
        configureBaseCircleLayer(circleLayer,
                                 lineWidth: lineWidth,
                                 color: Constants.circleLayerLineColor)
        addShadowToLayer(layer: circleLayer, radius: Constants.circleLayerShadowRadius)
        circleLayer.opacity = Constants.circleLayerOpacity
        addSublayer(circleLayer)
    }

    private func setupCompletedLayer(to value: Double, lineWidth: CGFloat, color: CGColor) {
        let progressLayer = CAShapeLayer()
        progressLayer.name = Constants.progressLayerName
        removeOldSublayer(name: Constants.progressLayerName)
        configureBaseCircleLayer(progressLayer,
                                lineWidth: lineWidth,
                                color: color)
        addShadowToLayer(layer: progressLayer, radius: Constants.progressLayerShadowRadius)
        progressLayer.cornerRadius = Constants.progressLayerCornerRadius
        progressLayer.strokeEnd = CGFloat(value)
        addSublayer(progressLayer)
    }

    private func removeOldSublayer(name: String) {
        sublayers?.removeAll(where: { (layer) -> Bool in
            layer.name == name
        })
    }

    private func configureBaseCircleLayer(_ layer: CAShapeLayer, lineWidth: CGFloat, color: CGColor) {
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / Constants.halfElementSizeDivider,
                                                           y: frame.size.height / Constants.halfElementSizeDivider),
                                        radius: (frame.size.width / Constants.halfElementSizeDivider) -
                                            (lineWidth / Constants.halfElementSizeDivider),
                                        startAngle: -.pi / Constants.halfElementSizeDivider,
                                        endAngle: Constants.circlePIFactor * .pi,
                                        clockwise: true)
        layer.path = circularPath.cgPath
        layer.fillColor = UIColor.clear.cgColor
        layer.lineCap = .round
        layer.lineWidth = lineWidth
        layer.strokeColor = color
    }

    private func addShadowToLayer(layer: CAShapeLayer, radius: CGFloat) {
        layer.shadowOpacity = Constants.shadowOpacity
        layer.shadowRadius = radius
        layer.shadowOffset = .zero
    }
}
