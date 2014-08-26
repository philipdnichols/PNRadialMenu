//
//  PNRadialMenuButton.h
//  PNRadialMenu
//
//  Created by Philip Nichols on 8/25/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PNRadialMenuButton : UIView

@property (strong, nonatomic) UIColor *color;
@property (strong, nonatomic) UIImage *image;

// Designated initializer
- (instancetype)initWithFrame:(CGRect)frame color:(UIColor *)color image:(UIImage *)image;

@end
