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
    
    UIFont *font = [UIFont boldSystemFontOfSize:12.0];
    NSDictionary *attributes = @{
                                 NSFontAttributeName : font,
                                 NSForegroundColorAttributeName : self.color,
                                 };
    CGSize size = [self.text sizeWithAttributes:attributes];
    
    self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    self.textLabel.attributedText = [[NSAttributedString alloc] initWithString:self.text attributes:attributes];
    self.textLabel.center = CGPointMake(self.center.x, self.bounds.size.height + self.textLabel.bounds.size.height / 2);
    
    [self addSubview:self.textLabel];
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

- (instancetype)initWithFrame:(CGRect)frame color:(UIColor *)color image:(UIImage *)image text:(NSString *)text
{
    self = [super initWithFrame:frame];
    if (self) {
        self.color = color;
        self.image = image;
        self.text = text;
        [self setup];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [self drawEllipseInRect:self.bounds
                  fillColor:[self.color CGColor]
                strokeColor:nil
                strokeWidth:0.0
                    context:context];
    
    CGRect imageRect = CGRectInset(self.bounds, 8, 8);
    [self.image drawInRect:imageRect blendMode:kCGBlendModeXOR alpha:1.0];
}

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

@end
