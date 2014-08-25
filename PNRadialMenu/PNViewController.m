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
@property (strong, nonatomic) UIView *modalView;

@end

@implementation PNViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.modalView = [[UIView alloc] initWithFrame:self.view.frame];
    self.modalView.hidden = YES;
    
    [self.view addSubview:self.modalView];
    
    UITapGestureRecognizer *modalViewTapGestureRecogizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(modalViewTapped)];
    [self.modalView addGestureRecognizer:modalViewTapGestureRecogizer];
    
    self.mainButton = [[PNRadialMenuMainButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    self.mainButton.center = self.view.center;
    
    [self.view addSubview:self.mainButton];
    
    UITapGestureRecognizer *mainButtonTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mainButtonTapped)];
    [self.mainButton addGestureRecognizer:mainButtonTapGestureRecognizer];
}

#pragma mark - IBActions

- (IBAction)mainButtonTapped
{
    [self animateTogglePresentAndDismissRadialMenu];
}

- (IBAction)modalViewTapped
{
    [self animateTogglePresentAndDismissRadialMenu];
}

#pragma mark - Animations

- (void)animateTogglePresentAndDismissRadialMenu
{
    [UIView animateWithDuration:0.35
                     animations:^{
                         if (self.mainButton.isMenuDisplayed) {
                             self.modalView.backgroundColor = [UIColor clearColor];
                             
                             self.mainButton.transform = CGAffineTransformIdentity;
                         } else {
                             self.modalView.hidden = NO;
                             self.modalView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.75];
                             
                             self.mainButton.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(-45));
                         }
                     } completion:^(BOOL finished) {
                         self.mainButton.isMenuDisplayed = !self.mainButton.isMenuDisplayed;
                         
                         if (!self.mainButton.isMenuDisplayed) {
                             self.modalView.hidden = YES;
                         }
                     }];
}

@end
