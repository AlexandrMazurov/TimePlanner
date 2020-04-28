//
//  ProgressView.swift
//  TimePlannerApp
//
//  Created by Mazurov, Aleksandr on 4/26/20.
//  Copyright © 2020 AlexandrMazurov. All rights reserved.
//

import UIKit

class ProgressView: UIView {

    private enum Constants {
        static let instantioateXibErrorMessage = "View not found"
        static let progressAnimationName = "strokeEnd"
        static let progressAnimationKey = "animateprogress"
        static let halfElementSizeDivider: CGFloat = 2
        static let shadowOpacity: Float = 1
        static let circlePIFactor: CGFloat = 1.5
        static let circleLayerLineWith: CGFloat = 7
        static let circleLayerLineColor: CGColor = UIColor.gray.cgColor
        static let circleLayerOpacity: Float = 0.5
        static let circleLayerShadowRadius: CGFloat = 1
        static let progressLayerLineWidth: CGFloat = 6
        static let progressLayerLineColor: CGColor = UIColor.red.cgColor
        static let progressLayerShadowRadius: CGFloat = 0.5
        static let progressLayerCornerRadius: CGFloat = 3
    }

    @IBOutlet weak var infoMetricLabel: UILabel!
    @IBOutlet weak var infoDiscriptionLabel: UILabel!

    private var circleLayer = CAShapeLayer()
    private var progressLayer = CAShapeLayer()
    private var currentProgressLayer = CAShapeLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    func setupInfo(with metric: String?, description: String) {
        infoMetricLabel.text = metric
        infoDiscriptionLabel.text = description
    }

    func confogureProgressView(duration: TimeInterval, fromValue: Double, toValue: Double) {
        setupCircleLayer()
        setupProgressLayer()
        fillCompletedLayer(to: fromValue)
        let circularProgressAnimation = CABasicAnimation(keyPath: Constants.progressAnimationName)
        circularProgressAnimation.duration = duration
        circularProgressAnimation.fromValue = fromValue
        circularProgressAnimation.toValue = toValue
        circularProgressAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        progressLayer.strokeStart = CGFloat(fromValue)
        progressLayer.strokeEnd = CGFloat(toValue)
        progressLayer.add(circularProgressAnimation, forKey: Constants.progressAnimationKey)
    }

    private func commonInit() {
        guard let view = UINib(nibName: "\(ProgressView.self)", bundle: .main)
            .instantiate(withOwner: self, options: nil).first as? UIView else {
                preconditionFailure(Constants.instantioateXibErrorMessage)
        }
        addSubview(view)
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

    private func fillCompletedLayer(to value: Double) {
        configureBaseCircleLayer(currentProgressLayer,
                                 lineWidth: progressLayer.lineWidth,
                                 color: Constants.progressLayerLineColor)
        addShadowToLayer(layer: currentProgressLayer, radius: progressLayer.shadowRadius)
        currentProgressLayer.cornerRadius = Constants.progressLayerCornerRadius
        currentProgressLayer.strokeEnd = CGFloat(value)
        layer.addSublayer(currentProgressLayer)
    }

    private func setupCircleLayer() {
        configureBaseCircleLayer(circleLayer,
                                 lineWidth: Constants.circleLayerLineWith,
                                 color: Constants.circleLayerLineColor)
        addShadowToLayer(layer: circleLayer, radius: Constants.circleLayerShadowRadius)
        circleLayer.opacity = Constants.circleLayerOpacity
        layer.addSublayer(circleLayer)
    }

    private func setupProgressLayer() {
        configureBaseCircleLayer(progressLayer,
                                 lineWidth: Constants.progressLayerLineWidth,
                                 color: Constants.progressLayerLineColor)
        addShadowToLayer(layer: progressLayer, radius: Constants.progressLayerShadowRadius)
        progressLayer.cornerRadius = Constants.progressLayerCornerRadius
        layer.addSublayer(progressLayer)
    }

    private func configureBaseCircleLayer(_ layer: CAShapeLayer, lineWidth: CGFloat, color: CGColor) {
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / Constants.halfElementSizeDivider,
                                                           y: frame.size.height / Constants.halfElementSizeDivider),
                                        radius: frame.size.width / Constants.halfElementSizeDivider,
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
