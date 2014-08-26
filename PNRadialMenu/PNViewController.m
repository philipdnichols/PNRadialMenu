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

#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

#define TealColor [UIColor colorWithRed:0.427 green:0.890 blue:0.729 alpha:1.000]
#define PeriwinkleColor [UIColor colorWithRed:0.416 green:0.769 blue:1.000 alpha:1.000]
#define OrangyColor [UIColor colorWithRed:0.973 green:0.541 blue:0.141 alpha:1.000]
#define YellowyColor [UIColor colorWithRed:0.992 green:0.910 blue:0.408 alpha:1.000]
#define LavenderColor [UIColor colorWithRed:0.733 green:0.612 blue:1.000 alpha:1.000]

@interface PNViewController ()

@property (strong, nonatomic) PNRadialMenuMainButton *mainButton;
@property (strong, nonatomic) NSMutableArray *menuButtons; // of PNRadialMenuButton
@property (strong, nonatomic) UIView *modalView;

@property (nonatomic) BOOL isAnimating;
@property (nonatomic) BOOL menuIsDisplayed;

@property (nonatomic) CGFloat arcSize;
@property (nonatomic) CGFloat radius;

@end

@implementation PNViewController

#pragma mark - Properties

- (NSMutableArray *)menuButtons
{
    if (!_menuButtons) {
        _menuButtons = [NSMutableArray array];
    }
    return _menuButtons;
}

- (CGFloat)arcSize
{
    return 150.0;
}

- (CGFloat)radius
{
    return 110.0;
}

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.modalView = [[UIView alloc] initWithFrame:self.view.frame];
    self.modalView.hidden = YES;
    
    [self.view addSubview:self.modalView];
    
    UITapGestureRecognizer *modalViewTapGestureRecogizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(modalViewTapped)];
    [self.modalView addGestureRecognizer:modalViewTapGestureRecogizer];
    
    CGRect buttonRect = CGRectMake(0, 0, 50, 50);
    CGPoint buttonPosition = CGPointMake(self.view.center.x, self.view.frame.size.height - buttonRect.size.height / 2 - 5);
    
    // Menu Buttons
    PNRadialMenuButton *menuButton1 = [[PNRadialMenuButton alloc] initWithFrame:buttonRect color:TealColor image:[UIImage imageNamed:@"clipboard"]];
    menuButton1.center = buttonPosition;
    menuButton1.hidden = YES;
    [self.view addSubview:menuButton1];
    [self.menuButtons addObject:menuButton1];
    
    PNRadialMenuButton *menuButton2 = [[PNRadialMenuButton alloc] initWithFrame:buttonRect color:PeriwinkleColor image:[UIImage imageNamed:@"clipboard"]];
    menuButton2.center = buttonPosition;
    menuButton2.hidden = YES;
    [self.view addSubview:menuButton2];
    [self.menuButtons addObject:menuButton2];
    
    PNRadialMenuButton *menuButton3 = [[PNRadialMenuButton alloc] initWithFrame:buttonRect color:OrangyColor image:[UIImage imageNamed:@"clipboard"]];
    menuButton3.center = buttonPosition;
    menuButton3.hidden = YES;
    [self.view addSubview:menuButton3];
    [self.menuButtons addObject:menuButton3];
    
    PNRadialMenuButton *menuButton4 = [[PNRadialMenuButton alloc] initWithFrame:buttonRect color:YellowyColor image:[UIImage imageNamed:@"clipboard"]];
    menuButton4.center = buttonPosition;
    menuButton4.hidden = YES;
    [self.view addSubview:menuButton4];
    [self.menuButtons addObject:menuButton4];
    
    PNRadialMenuButton *menuButton5 = [[PNRadialMenuButton alloc] initWithFrame:buttonRect color:LavenderColor image:[UIImage imageNamed:@"clipboard"]];
    menuButton5.center = buttonPosition;
    menuButton5.hidden = YES;
    [self.view addSubview:menuButton5];
    [self.menuButtons addObject:menuButton5];
    
    self.mainButton = [[PNRadialMenuMainButton alloc] initWithFrame:buttonRect];
    self.mainButton.center = buttonPosition;
    
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
    if (!self.isAnimating) {
        if (self.menuIsDisplayed) {
            self.isAnimating = YES;
            
            [UIView animateWithDuration:0.5
                                  delay:0.0
                                options:kNilOptions
                             animations:^{
                                 self.modalView.backgroundColor = [UIColor clearColor];
                                 
                                 self.mainButton.transform = CGAffineTransformIdentity;
                                 
                                 [self.menuButtons enumerateObjectsUsingBlock:^(PNRadialMenuButton *menuButton, NSUInteger idx, BOOL *stop) {
                                     menuButton.transform = CGAffineTransformIdentity;
                                 }];
                             }
                             completion:^(BOOL finished) {
                                 self.isAnimating = NO;
                                 self.menuIsDisplayed = NO;
                                 
                                 self.modalView.hidden = YES;
                                 
                                 [self.menuButtons enumerateObjectsUsingBlock:^(PNRadialMenuButton *menuButton, NSUInteger idx, BOOL *stop) {
                                     menuButton.hidden = YES;
                                 }];
                             }];
        } else {
            self.isAnimating = YES;
            self.modalView.hidden = NO;
            [self.menuButtons enumerateObjectsUsingBlock:^(PNRadialMenuButton *menuButton, NSUInteger idx, BOOL *stop) {
                menuButton.hidden = NO;
            }];
            
            [UIView animateWithDuration:0.5
                                  delay:0.0
                                options:kNilOptions
                             animations:^{
                                 self.modalView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.75];
                                 
                                 CGFloat startAngle = 15;
                                 CGFloat angle = (self.arcSize >= 360) ? (360 / [self.menuButtons count]) : (([self.menuButtons count] > 1) ? (self.arcSize / ([self.menuButtons count] - 1)) : 0.0);
                                 [self.menuButtons enumerateObjectsUsingBlock:^(PNRadialMenuButton *menuButton, NSUInteger idx, BOOL *stop) {
                                     CGFloat radians = DEGREES_TO_RADIANS(startAngle + (angle * idx));
                                     
                                     CGFloat x = self.radius * cos(radians);
                                     CGFloat y = -self.radius * sin(radians);
                                     menuButton.transform = CGAffineTransformMakeTranslation(x, y);
                                 }];
                                 
                                 self.mainButton.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(-45));
                             }
                             completion:^(BOOL finished) {
                                 self.isAnimating = NO;
                                 self.menuIsDisplayed = YES;
                             }];
        }
    
    }
    
//    [UIView animateWithDuration:0.5
//                          delay:0.0
//         usingSpringWithDamping:0.5
//          initialSpringVelocity:0.0
//                        options:kNilOptions
//                     animations:^{
//                         if (!self.mainButton.isMenuDisplayed) {
//                             self.menuButton.hidden = NO;
//                             self.menuButton.transform = CGAffineTransformMakeTranslation(0, 100);
//                         }
//                     }
//                     completion:nil];
//    
//    [UIView animateWithDuration:0.45
//                     animations:^{
//                         if (self.mainButton.isMenuDisplayed) {
//                             self.menuButton.transform = CGAffineTransformMakeTranslation(0, 110);
//                         }
//                     }
//                     completion:^(BOOL finished) {
//                         [UIView animateWithDuration:0.05
//                                               delay:0.0
//                                             options:kNilOptions
//                                          animations:^{
//                                              self.menuButton.transform = CGAffineTransformIdentity;
//                                          }
//                                          completion:nil];
//                     }];
}

@end
