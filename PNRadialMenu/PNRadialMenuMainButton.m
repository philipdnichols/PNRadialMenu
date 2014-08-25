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
    UIBezierPath *mainButtonOutlinePath = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
    [[UIColor whiteColor] setFill];
    [mainButtonOutlinePath fill];
    
    CGFloat outlineWidth = 3;
    UIBezierPath *mainButtonPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(self.bounds.origin.x + (outlineWidth / 2),
                                                                                     self.bounds.origin.y + (outlineWidth / 2),
                                                                                     self.bounds.size.width - outlineWidth,
                                                                                     self.bounds.size.height - outlineWidth)];
    [[UIColor colorWithRed:0.122 green:0.404 blue:0.765 alpha:1.000] setFill];
    [mainButtonPath fill];
    
    CGFloat radiusX = self.bounds.size.width / 2;
    CGFloat radiusY = self.bounds.size.height / 2;
    
    CGPoint verticalStartPoint = CGPointMake(self.bounds.origin.x + radiusX, self.bounds.origin.y + (radiusY / 2));
    CGPoint verticalEndPoint = CGPointMake(self.bounds.origin.x + radiusX, self.bounds.origin.y + 3 * (radiusY / 2));
    
    CGFloat lineWidth = 4;
    UIBezierPath *verticalLinePath = [[UIBezierPath alloc] init];
    verticalLinePath.lineWidth = lineWidth;
    verticalLinePath.lineCapStyle = kCGLineCapRound;
    [verticalLinePath moveToPoint:verticalStartPoint];
    [verticalLinePath addLineToPoint:verticalEndPoint];
    
    [[UIColor whiteColor] setStroke];
    [verticalLinePath stroke];
    
    CGPoint horizontalStartPoint = CGPointMake(self.bounds.origin.x + (radiusX / 2), self.bounds.origin.y + radiusY);
    CGPoint horizontalEndPoint = CGPointMake(self.bounds.origin.x + 3 * (radiusX / 2), self.bounds.origin.y + radiusY);
    
    UIBezierPath *horizontalLinePath = [[UIBezierPath alloc] init];
    horizontalLinePath.lineWidth = lineWidth;
    horizontalLinePath.lineCapStyle = kCGLineCapRound;
    [horizontalLinePath moveToPoint:horizontalStartPoint];
    [horizontalLinePath addLineToPoint:horizontalEndPoint];
    
    [[UIColor whiteColor] setStroke];
    [horizontalLinePath stroke];
}

@end
