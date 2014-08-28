//
//  PNRadialMenu.h
//  PNRadialMenu
//
//  Created by Philip Nichols on 8/27/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PNRadialMenu : NSObject

- (instancetype)initInView:(UIView *)view;

+ (instancetype)radialMenuInView:(UIView *)view;

@property (nonatomic) CGFloat duration;
@property (nonatomic) CGPoint center;
@property (nonatomic) CGFloat arcSize;
@property (nonatomic) CGFloat startAngle;
@property (nonatomic) CGFloat horizontalRadius;
@property (nonatomic) CGFloat verticalRadius;

@property (nonatomic, getter = isCenteredArc) BOOL centeredArc;
@property (nonatomic, readonly, getter = isAnimating) BOOL animating;
@property (nonatomic, readonly, getter = isDisplayed) BOOL displayed;

- (void)configureMainButtonWithFrame:(CGRect)frame;

- (void)addMenuButtonWithFrame:(CGRect)frame color:(UIColor *)color image:(UIImage *)image text:(NSString *)text;

@end
