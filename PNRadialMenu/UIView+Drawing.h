//
//  UIView+Drawing.h
//  PNRadialMenu
//
//  Created by Philip Nichols on 8/27/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Drawing)

- (void)drawEllipseInRect:(CGRect)rect
                fillColor:(CGColorRef)fillColor
              strokeColor:(CGColorRef)strokeColor
              strokeWidth:(CGFloat)strokeWidth
                  context:(CGContextRef)context;

- (void)drawLineAtPoint:(CGPoint)startPoint
                toPoint:(CGPoint)endPoint
              lineWidth:(CGFloat)lineWidth
                lineCap:(CGLineCap)lineCap
                  color:(CGColorRef)color
                context:(CGContextRef)context;

@end
