//
//  PNRadialMenuMainButton.m
//  PNRadialMenu
//
//  Created by Philip Nichols on 8/25/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import "PNRadialMenuMainButton.h"

@implementation PNRadialMenuMainButton

#pragma mark - Initialization

- (void)setup
{
    self.backgroundColor = nil;
    self.opaque = NO;
    self.contentMode = UIViewContentModeRedraw;
    self.clipsToBounds = NO;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setup];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [self drawEllipseInRect:self.bounds
                  fillColor:[[UIColor colorWithRed:0.122 green:0.404 blue:0.765 alpha:1.000] CGColor]
                strokeColor:[[UIColor whiteColor] CGColor]
                strokeWidth:2
                    context:context];
    
    CGFloat lineWidth = 4;
    CGLineCap lineCap = kCGLineCapRound;
    CGColorRef lineColor = [[UIColor whiteColor] CGColor];
    
    CGFloat radiusX = self.bounds.size.width / 2;
    CGFloat radiusY = self.bounds.size.height / 2;
    
    CGPoint verticalStartPoint = CGPointMake(self.bounds.origin.x + radiusX, self.bounds.origin.y + (radiusY / 2));
    CGPoint verticalEndPoint = CGPointMake(self.bounds.origin.x + radiusX, self.bounds.origin.y + 3 * (radiusY / 2));
    CGPoint horizontalStartPoint = CGPointMake(self.bounds.origin.x + (radiusX / 2), self.bounds.origin.y + radiusY);
    CGPoint horizontalEndPoint = CGPointMake(self.bounds.origin.x + 3 * (radiusX / 2), self.bounds.origin.y + radiusY);
    
    [self drawLineAtPoint:verticalStartPoint
                  toPoint:verticalEndPoint
                lineWidth:lineWidth
                  lineCap:lineCap
                    color:lineColor
                  context:context];
    
    [self drawLineAtPoint:horizontalStartPoint
                  toPoint:horizontalEndPoint
                lineWidth:lineWidth
                  lineCap:lineCap
                    color:lineColor
                  context:context];
}

// TODO: Create a circular button uiview class that the main menu button and radial menu buttons can inherit from
- (void)drawEllipseInRect:(CGRect)rect fillColor:(CGColorRef)fillColor strokeColor:(CGColorRef)strokeColor strokeWidth:(CGFloat)strokeWidth context:(CGContextRef)context
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

- (void)drawLineAtPoint:(CGPoint)startPoint toPoint:(CGPoint)endPoint lineWidth:(CGFloat)lineWidth lineCap:(CGLineCap)lineCap color:(CGColorRef)color context:(CGContextRef)context
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
