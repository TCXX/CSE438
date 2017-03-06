//
//  PathView.swift
//  Lab3
//
//  Created by XINYI on 2/11/17.
//  Copyright © 2017 Tianxinxin iOS. All rights reserved.
//

import UIKit

class PathView: UIView {
    var thePath: BoardPath? {
        didSet {
            setNeedsDisplay()
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        if (thePath == nil) {
            return
        }
        
        let len = thePath!.points.count
        if (len == 0) {
            return
        }
        
        let thickness = (thePath?.thickness)!
        let color: UIColor = (thePath?.color)!
        let alpha = (thePath?.alpha)!
        
        let path = createQuadPath(points: thePath!.points)
        path.lineWidth = thickness
        color.setStroke()
        path.stroke(with: .normal, alpha: alpha)
        
        let dot0 = createDot(point: thePath!.points[0], radius: thickness/2)
        let dot1 = createDot(point: thePath!.points[len-1], radius: thickness/2)
        color.setFill()
        dot0.fill(with: .normal, alpha: alpha)
        dot1.fill(with: .normal, alpha: alpha)
    }
    
    private func midpoint(first: CGPoint, second: CGPoint) -> CGPoint {
        let midX = (first.x + second.x)/2
        let midY = (first.y + second.y)/2
        return CGPoint(x: midX, y: midY)
    }
    
    func createQuadPath(points: [CGPoint]) -> UIBezierPath {
        let path = UIBezierPath()
        if points.count < 2 { return path }
        let firstPoint = points[0]
        let secondPoint = points[1]
        let firstMidpoint = midpoint(first: firstPoint, second: secondPoint)
        path.move(to: firstPoint)
        path.addLine(to: firstMidpoint)
        for index in 1 ..< points.count-1 {
            let currentPoint = points[index]
            let nextPoint = points[index + 1]
            let midPoint = midpoint(first: currentPoint, second: nextPoint)
            path.addQuadCurve(to: midPoint, controlPoint: currentPoint)
        }
        guard let lastLocation = points.last else { return path }
        path.addLine(to: lastLocation)
        return path
    }
    
    func createDot(point: CGPoint, radius: CGFloat) -> UIBezierPath {
        let path = UIBezierPath()
        path.addArc(withCenter: point, radius: radius, startAngle: 0, endAngle: CGFloat(M_PI * 2), clockwise: true)
        return path
    }
}
