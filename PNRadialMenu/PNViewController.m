//
//  PNViewController.m
//  PNRadialMenu
//
//  Created by Philip Nichols on 8/25/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import "PNViewController.h"
#import "PNRadialMenuMainButton.h"

@interface PNViewController ()

@end

@implementation PNViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    PNRadialMenuMainButton *mainButton = [[PNRadialMenuMainButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    mainButton.center = self.view.center;
    
    [self.view addSubview:mainButton];
}

@end
