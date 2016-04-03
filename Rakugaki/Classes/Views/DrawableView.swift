//
//  DrawableView.swift
//  Rakugaki
//
//  Created by Shun Kuroda on 2016/04/02.
//  Copyright © 2016年 kuroyam. All rights reserved.
//

import UIKit

class DrawableView: UIView {
    
    var lines: [Line] = []
    var currentLine: Line? = nil
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let point = touches.first!.locationInView(self)
        currentLine = Line(color: UIColor.greenColor().CGColor, width: 5)
        currentLine?.points.append(point)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let point = touches.first!.locationInView(self)
        currentLine?.points.append(point)
        setNeedsDisplay()
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if currentLine?.points.count > 1 {
            lines.append(currentLine!)
        }
        currentLine = nil
        setNeedsDisplay()
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        
    }
    
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        resetContext(context!)
        
        lines.forEach { line in
            line.drawOnContext(context!)
        }
        
        if let line = currentLine {
            line.drawOnContext(context!)
        }
    }
    
    func resetContext(context: CGContextRef) {
        CGContextClearRect(context, bounds)
        if let color = backgroundColor {
            color.setFill()
        } else {
            UIColor.whiteColor().setFill()
        }
        CGContextFillRect(context, bounds)
    }
    
}

protocol DrawableViewPart {
    func drawOnContext(context: CGContextRef)
}

extension DrawableView {
    
    class Line: DrawableViewPart {
        
        var points: [CGPoint]
        let color: CGColorRef
        let width: CGFloat
        
        init(color: CGColorRef, width: CGFloat) {
            self.points = []
            self.color = color
            self.width = width
        }
        
        func drawOnContext(context: CGContextRef) {
            UIGraphicsPushContext(context)
            
            CGContextSetStrokeColorWithColor(context, color)
            CGContextSetLineWidth(context, width)
            CGContextSetLineCap(context, CGLineCap.Round)
            for (index, point) in points.enumerate() where points.count > 1 {
                if index == 0 {
                    CGContextMoveToPoint(context, point.x, point.y)
                } else {
                    CGContextAddLineToPoint(context, point.x, point.y)
                }
            }
            CGContextStrokePath(context)
            
            UIGraphicsPopContext()
        }
        
    }
    
}
