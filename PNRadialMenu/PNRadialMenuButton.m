//
//  PNRadialMenuButton.m
//  PNRadialMenu
//
//  Created by Philip Nichols on 8/25/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import "PNRadialMenuButton.h"

@implementation PNRadialMenuButton

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

- (id)initWithFrame:(CGRect)frame
{
    NSAssert(NO, @"'initWithFrame' is not supported. Please use the designated initializer 'initWithFrame:color:image'");
    return nil;
}

- (instancetype)initWithFrame:(CGRect)frame color:(UIColor *)color image:(UIImage *)image
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
        self.color = color;
        self.image = image;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    UIBezierPath *mainButtonOutlinePath = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
    [self.color setFill];
    [mainButtonOutlinePath fill];
    
    CGRect imageRect = CGRectInset(self.bounds, 8, 8);
    [self.image drawInRect:imageRect blendMode:kCGBlendModeXOR alpha:1.0];
}

@end
