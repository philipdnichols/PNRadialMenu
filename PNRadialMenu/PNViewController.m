//
//  PNViewController.m
//  PNRadialMenu
//
//  Created by Philip Nichols on 8/25/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import "PNViewController.h"
#import "PNRadialMenuMainButton.h"
#import "PNRadialMenuButton.h"
#import "PNRadialMenu.h"

#define TealColor [UIColor colorWithRed:0.427 green:0.890 blue:0.729 alpha:1.000]
#define PeriwinkleColor [UIColor colorWithRed:0.416 green:0.769 blue:1.000 alpha:1.000]
#define OrangyColor [UIColor colorWithRed:0.973 green:0.541 blue:0.141 alpha:1.000]
#define YellowyColor [UIColor colorWithRed:0.992 green:0.910 blue:0.408 alpha:1.000]
#define LavenderColor [UIColor colorWithRed:0.733 green:0.612 blue:1.000 alpha:1.000]

@interface PNViewController ()

@property (strong, nonatomic) PNRadialMenu *radialMenu;

@end

@implementation PNViewController

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"PNRadialMenu";
    
    CGRect mainButtonRect = CGRectMake(0, 0, 50, 50);
    CGRect menuButtonRect = CGRectMake(0, 0, 47.5, 47.5);
    CGPoint buttonPosition = CGPointMake(self.view.center.x, self.view.frame.size.height - mainButtonRect.size.height / 2 - 5);
    
    self.radialMenu = [PNRadialMenu radialMenuInView:self.view];
    self.radialMenu.duration = 0.5;
    self.radialMenu.center = buttonPosition;
    self.radialMenu.arcSize = 125.0;
    self.radialMenu.centeredArc = YES;
    self.radialMenu.horizontalRadius = 140.0;
    self.radialMenu.verticalRadius = 130.0;
    
    [self.radialMenu configureMainButtonWithFrame:mainButtonRect];
    
    [self.radialMenu addMenuButtonWithFrame:menuButtonRect
                                      color:LavenderColor
                                      image:[UIImage imageNamed:@"clipboard"]
                                       text:@"Tasks"];
    [self.radialMenu addMenuButtonWithFrame:menuButtonRect
                                      color:YellowyColor
                                      image:[UIImage imageNamed:@"worldwideLocation"]
                                       text:@"Location"];
    [self.radialMenu addMenuButtonWithFrame:menuButtonRect
                                      color:OrangyColor
                                      image:[UIImage imageNamed:@"calendar"]
                                       text:@"Calendar"];
    [self.radialMenu addMenuButtonWithFrame:menuButtonRect
                                      color:PeriwinkleColor
                                      image:[UIImage imageNamed:@"alarmClock"]
                                       text:@"Alarms"];
    [self.radialMenu addMenuButtonWithFrame:menuButtonRect
                                      color:TealColor
                                      image:[UIImage imageNamed:@"help"]
                                       text:@"Help"];
}

@end
