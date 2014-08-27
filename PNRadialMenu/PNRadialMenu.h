//
//  PNRadialMenu.h
//  PNRadialMenu
//
//  Created by Philip Nichols on 8/27/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PNRadialMenu : NSObject

- (instancetype)init;

- (instancetype)radialMenu;

@property (nonatomic) CGFloat arcSize;
@property (nonatomic) CGFloat horizontalRadius;
@property (nonatomic) CGFloat verticalRadius;

@end
