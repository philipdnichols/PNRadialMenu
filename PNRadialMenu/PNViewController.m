//
//  PNViewController.m
//  PNRadialMenu
//
//  Created by Philip Nichols on 8/25/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import "PNViewController.h"
#import "PNRadialMenuMainButton.h"

#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

@interface PNViewController ()

@property (strong, nonatomic) PNRadialMenuMainButton *mainButton;

@end

@implementation PNViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.mainButton = [[PNRadialMenuMainButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    self.mainButton.center = self.view.center;
    
    [self.view addSubview:self.mainButton];
    
    UITapGestureRecognizer *mainButtonTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mainButtonTapped:)];
    [self.mainButton addGestureRecognizer:mainButtonTapGestureRecognizer];
}

- (void)mainButtonTapped:(UITapGestureRecognizer *)tapGestureRecognizer
{
    [UIView animateWithDuration:0.5
                     animations:^{
                         if (self.mainButton.isMenuDisplayed) {
                             self.mainButton.transform = CGAffineTransformIdentity;
                         } else {
                             self.mainButton.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(-45));
                         }
                     } completion:^(BOOL finished) {
                         self.mainButton.isMenuDisplayed = !self.mainButton.isMenuDisplayed;
                     }];
}

@end
