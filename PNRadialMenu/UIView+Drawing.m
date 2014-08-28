//
//  UIView+Drawing.m
//  PNRadialMenu
//
//  Created by Philip Nichols on 8/27/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import "UIView+Drawing.h"

@implementation UIView (Drawing)

- (void)drawEllipseInRect:(CGRect)rect
                fillColor:(CGColorRef)fillColor
              strokeColor:(CGColorRef)strokeColor
              strokeWidth:(CGFloat)strokeWidth
                  context:(CGContextRef)context
{
    UIGraphicsPushContext(context);
    
    CGContextSetFillColorWithColor(context, fillColor);
    CGContextSetStrokeColorWithColor(context, strokeColor);
    CGContextSetLineWidth(context, strokeWidth);
    
    CGRect rectToDraw = CGRectInset(rect, strokeWidth / 2, strokeWidth / 2);
    
    if (fillColor) {
        CGContextFillEllipseInRect(context, rectToDraw);
    } else {
        CGContextAddEllipseInRect(context, rectToDraw);
    }
    
    if (strokeColor) {
        CGContextStrokeEllipseInRect(context, rectToDraw);
    }
    
    UIGraphicsPopContext();
}

- (void)drawLineAtPoint:(CGPoint)startPoint
                toPoint:(CGPoint)endPoint
              lineWidth:(CGFloat)lineWidth
                lineCap:(CGLineCap)lineCap
                  color:(CGColorRef)color
                context:(CGContextRef)context
{
    UIGraphicsPushContext(context);
    
    CGContextSetLineWidth(context, lineWidth);
    CGContextSetLineCap(context, lineCap);
    CGContextSetStrokeColorWithColor(context, color);
    
    CGContextMoveToPoint(context, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
    CGContextStrokePath(context);
    
    UIGraphicsPopContext();
}

@end
