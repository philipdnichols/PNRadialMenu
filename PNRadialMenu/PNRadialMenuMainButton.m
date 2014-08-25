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
    UIBezierPath *mainButtonPath = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
    mainButtonPath.lineWidth = 3;
    
    [[UIColor colorWithRed:0.122 green:0.404 blue:0.765 alpha:1.000] setFill];
    [[UIColor whiteColor] setStroke];
    [mainButtonPath fill];
    [mainButtonPath stroke];
    
    CGFloat radiusX = self.bounds.size.width / 2;
    CGFloat radiusY = self.bounds.size.height / 2;
    
    CGPoint verticalStartPoint = CGPointMake(self.bounds.origin.x + radiusX, self.bounds.origin.y + (radiusY / 2));
    CGPoint verticalEndPoint = CGPointMake(self.bounds.origin.x + radiusX, self.bounds.origin.y + 3 * (radiusY / 2));
    
    UIBezierPath *verticalLinePath = [[UIBezierPath alloc] init];
    verticalLinePath.lineWidth = 4;
    verticalLinePath.lineCapStyle = kCGLineCapRound;
    [verticalLinePath moveToPoint:verticalStartPoint];
    [verticalLinePath addLineToPoint:verticalEndPoint];
    
    [[UIColor whiteColor] setStroke];
    [verticalLinePath stroke];
    
    CGPoint horizontalStartPoint = CGPointMake(self.bounds.origin.x + (radiusX / 2), self.bounds.origin.y + radiusY);
    CGPoint horizontalEndPoint = CGPointMake(self.bounds.origin.x + 3 * (radiusX / 2), self.bounds.origin.y + radiusY);
    
    UIBezierPath *horizontalLinePath = [[UIBezierPath alloc] init];
    horizontalLinePath.lineWidth = 4;
    horizontalLinePath.lineCapStyle = kCGLineCapRound;
    [horizontalLinePath moveToPoint:horizontalStartPoint];
    [horizontalLinePath addLineToPoint:horizontalEndPoint];
    
    [[UIColor whiteColor] setStroke];
    [horizontalLinePath stroke];
}

@end
