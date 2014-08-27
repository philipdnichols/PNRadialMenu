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
@property (strong, nonatomic) NSString *text;

// FIXME: Exposing this for testing purposes
@property (strong, nonatomic) UILabel *textLabel;

// Designated initializer
- (instancetype)initWithFrame:(CGRect)frame color:(UIColor *)color image:(UIImage *)image text:(NSString *)text;

@end
