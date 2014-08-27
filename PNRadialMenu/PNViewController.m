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
@property (nonatomic) CGFloat xRadius;
@property (nonatomic) CGFloat yRadius;

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
    return 125.0;
}

- (CGFloat)xRadius
{
    return 140.0;
}

- (CGFloat)yRadius
{
    return 130.0;
}

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"PNRadialMenu";
    
    UIView *view = self.navigationController.view;
    
    self.modalView = [[UIView alloc] initWithFrame:view.frame];
    self.modalView.backgroundColor = [UIColor blackColor];
    self.modalView.hidden = YES;
    
    [view addSubview:self.modalView];
    
    UITapGestureRecognizer *modalViewTapGestureRecogizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(modalViewTapped)];
    [self.modalView addGestureRecognizer:modalViewTapGestureRecogizer];
    
    CGRect mainButtonRect = CGRectMake(0, 0, 50, 50);
    CGRect menuButtonRect = CGRectMake(0, 0, 47.5, 47.5);
    CGPoint buttonPosition = CGPointMake(view.center.x, view.frame.size.height - mainButtonRect.size.height / 2 - 5);
    
    // Menu Buttons
    PNRadialMenuButton *menuButton1 = [[PNRadialMenuButton alloc] initWithFrame:menuButtonRect color:TealColor image:[UIImage imageNamed:@"help"] text:@"Help"];
    menuButton1.center = buttonPosition;
    menuButton1.hidden = YES;
    [menuButton1 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(menuButtonTapped:)]];
    [view addSubview:menuButton1];
    [self.menuButtons addObject:menuButton1];
    
    PNRadialMenuButton *menuButton2 = [[PNRadialMenuButton alloc] initWithFrame:menuButtonRect color:PeriwinkleColor image:[UIImage imageNamed:@"alarmClock"] text:@"Alarms"];
    menuButton2.center = buttonPosition;
    menuButton2.hidden = YES;
    [menuButton2 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(menuButtonTapped:)]];
    [view addSubview:menuButton2];
    [self.menuButtons addObject:menuButton2];
    
    PNRadialMenuButton *menuButton3 = [[PNRadialMenuButton alloc] initWithFrame:menuButtonRect color:OrangyColor image:[UIImage imageNamed:@"calendar"] text:@"Calendar"];
    menuButton3.center = buttonPosition;
    menuButton3.hidden = YES;
    [menuButton3 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(menuButtonTapped:)]];
    [view addSubview:menuButton3];
    [self.menuButtons addObject:menuButton3];
    
    PNRadialMenuButton *menuButton4 = [[PNRadialMenuButton alloc] initWithFrame:menuButtonRect color:YellowyColor image:[UIImage imageNamed:@"worldwideLocation"] text:@"Location"];
    menuButton4.center = buttonPosition;
    menuButton4.hidden = YES;
    [menuButton4 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(menuButtonTapped:)]];
    [view addSubview:menuButton4];
    [self.menuButtons addObject:menuButton4];
    
    PNRadialMenuButton *menuButton5 = [[PNRadialMenuButton alloc] initWithFrame:menuButtonRect color:LavenderColor image:[UIImage imageNamed:@"clipboard"] text:@"Tasks"];
    menuButton5.center = buttonPosition;
    menuButton5.hidden = YES;
    [menuButton5 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(menuButtonTapped:)]];
    [view addSubview:menuButton5];
    [self.menuButtons addObject:menuButton5];
    
    self.mainButton = [[PNRadialMenuMainButton alloc] initWithFrame:mainButtonRect];
    self.mainButton.center = buttonPosition;
    
    [view addSubview:self.mainButton];
    
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

- (void)menuButtonTapped:(UITapGestureRecognizer *)tapGesture
{
    if (!self.isAnimating) {
        self.isAnimating = YES;
        
        [self animateModalDismiss];
        [self animateMainButtonClose];
        [self animateMenuButtonsSelect:(PNRadialMenuButton *)tapGesture.view];
        [self animateMenuButtonsNoSelect:self.menuButtons exclude:(PNRadialMenuButton *)tapGesture.view];
    }
}

#pragma mark - Animations

- (void)animateTogglePresentAndDismissRadialMenu
{
    if (!self.isAnimating) {
        if (self.menuIsDisplayed) {
            self.isAnimating = YES;
            
            [self animateModalDismiss];
            
            [self animateMainButtonClose];
            
            [self animateMenuButtonsDismiss];
        } else {
            self.isAnimating = YES;
            self.modalView.hidden = NO;
            [self.menuButtons enumerateObjectsUsingBlock:^(PNRadialMenuButton *menuButton, NSUInteger idx, BOOL *stop) {
                menuButton.hidden = NO;
            }];
            
            [self animateModalDisplay];
            
            [self animateMainButtonOpen];
            
            [self animateMenuButtonsDisplay];
        }
    }
}

- (void)animateMainButtonOpen
{
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotateAnimation.duration = 0.5;
    rotateAnimation.fromValue = @(DEGREES_TO_RADIANS(0));
    rotateAnimation.toValue = @(DEGREES_TO_RADIANS(-45));
    rotateAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    rotateAnimation.delegate = self;
    
    [self.mainButton.layer addAnimation:rotateAnimation forKey:@"rotate-45"];
    self.mainButton.layer.transform = CATransform3DMakeRotation(DEGREES_TO_RADIANS(-45), 0, 0, 1);
}

- (void)animateMainButtonClose
{
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotateAnimation.duration = 0.5;
    rotateAnimation.fromValue = @(DEGREES_TO_RADIANS(-45));
    rotateAnimation.toValue = @(DEGREES_TO_RADIANS(0));
    rotateAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    rotateAnimation.delegate = self;
    
    [self.mainButton.layer addAnimation:rotateAnimation forKey:@"rotate45"];
    self.mainButton.layer.transform = CATransform3DMakeRotation(DEGREES_TO_RADIANS(0), 0, 0, 1);
}

//- (void)animateModalDisplay
//{
//    CABasicAnimation *backgroundColorAnimation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
//    backgroundColorAnimation.duration = 0.5;
//    backgroundColorAnimation.fromValue = [UIColor clearColor];
//    backgroundColorAnimation.toValue = [UIColor colorWithWhite:0.0 alpha:0.75];
//    backgroundColorAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    
//    [self.modalView.layer addAnimation:backgroundColorAnimation forKey:@"modalViewBackgroundColor"];
//    self.modalView.layer.backgroundColor = [[UIColor colorWithWhite:0.0 alpha:0.75] CGColor];
//}

- (void)animateModalDisplay
{
    CABasicAnimation *opactiyAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opactiyAnimation.duration = 0.5;
    opactiyAnimation.fromValue = @0.0;
    opactiyAnimation.toValue = @0.75;
    opactiyAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [self.modalView.layer addAnimation:opactiyAnimation forKey:@"transparentToOpaque"];
    self.modalView.layer.opacity = 0.75;
}

//- (void)animateModalDismiss
//{
//    CABasicAnimation *backgroundColorAnimation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
//    backgroundColorAnimation.duration = 0.5;
//    backgroundColorAnimation.fromValue = [UIColor colorWithWhite:0.0 alpha:0.75];
//    backgroundColorAnimation.toValue = [UIColor clearColor];
//    backgroundColorAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    
//    [self.modalView.layer addAnimation:backgroundColorAnimation forKey:@"modalViewBackgroundColor"];
//    self.modalView.layer.backgroundColor = [[UIColor clearColor] CGColor];
//}

- (void)animateModalDismiss
{
    CABasicAnimation *opactiyAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opactiyAnimation.duration = 0.5;
    opactiyAnimation.fromValue = @0.75;
    opactiyAnimation.toValue = @0.0;
    opactiyAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [self.modalView.layer addAnimation:opactiyAnimation forKey:@"opaqueToTransparent"];
    self.modalView.layer.opacity = 0.0;
}

- (void)animateMenuButtonsDisplay
{
    CGFloat startAngle = 27.5;
    CGFloat angle = (self.arcSize >= 360) ? (360 / [self.menuButtons count]) : (([self.menuButtons count] > 1) ? (self.arcSize / ([self.menuButtons count] - 1)) : 0.0);
    
    CABasicAnimation *position = [CABasicAnimation animationWithKeyPath:@"position"];
    position.duration = 0.5;
    position.fromValue = [NSValue valueWithCGPoint:self.mainButton.layer.position];
    position.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.82 :1.69 :0.11 :0.61];
    
    CABasicAnimation *opacity = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacity.duration = 0.2;
    opacity.fromValue = @0.0;
    opacity.toValue = @1.0;
    
    [self.menuButtons enumerateObjectsUsingBlock:^(PNRadialMenuButton *menuButton, NSUInteger idx, BOOL *stop) {
        CGFloat radians = DEGREES_TO_RADIANS(startAngle + (angle * idx));
        CGFloat x = self.xRadius * cos(radians);
        CGFloat y = -self.yRadius * sin(radians);
        
        CGAffineTransform transform = CGAffineTransformMakeTranslation(x, y);
        CGPoint point = CGPointApplyAffineTransform(menuButton.layer.position, transform);
        
        position.toValue = [NSValue valueWithCGPoint:point];
        
        [menuButton.layer addAnimation:position forKey:[NSString stringWithFormat:@"menuButtonPositioning-%d", idx]];
        [menuButton.textLabel.layer addAnimation:opacity forKey:@"translucentToOpaque"];
        
        menuButton.layer.position = point;
        menuButton.textLabel.layer.opacity = 1.0;
    }];
}

- (void)animateMenuButtonsDismiss
{
    CABasicAnimation *position = [CABasicAnimation animationWithKeyPath:@"position"];
    position.duration = 0.5;
    position.toValue = [NSValue valueWithCGPoint:self.mainButton.layer.position];
    position.timingFunction = [CAMediaTimingFunction functionWithControlPoints:1.0 :-0.07 :0.86 :-0.24];
    
    CABasicAnimation *opacity = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacity.duration = 0.2;
    opacity.fromValue = @1.0;
    opacity.toValue = @0.0;
    
    [self.menuButtons enumerateObjectsUsingBlock:^(PNRadialMenuButton *menuButton, NSUInteger idx, BOOL *stop) {
        position.fromValue = [NSValue valueWithCGPoint:menuButton.layer.position];
        
        [menuButton.layer addAnimation:position forKey:[NSString stringWithFormat:@"menuButtonPositioning-%d", idx]];
        [menuButton.textLabel.layer addAnimation:opacity forKey:@"opaqueToTranslucent"];
        
        menuButton.layer.position = self.mainButton.layer.position;
        menuButton.textLabel.layer.opacity = 0.0;
    }];
}

- (void)animateMenuButtonsSelect:(PNRadialMenuButton *)menuButton
{
    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scale.duration = 0.5;
    scale.fromValue = @1;
    scale.toValue = @2;
    [menuButton.layer addAnimation:scale forKey:@"scaleTimes3"];
    menuButton.layer.transform = CATransform3DMakeScale(2, 2, 0);
    
    CABasicAnimation *fade = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fade.duration = 0.5;
    fade.fromValue = @1;
    fade.toValue = @0;
    [menuButton.layer addAnimation:fade forKey:@"fadeToNothing"];
    menuButton.layer.opacity = 0.0;
}

- (void)animateMenuButtonsNoSelect:(NSArray *)menuButtons exclude:(PNRadialMenuButton *)selectedMenuButton
{
    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scale.duration = 0.5;
    scale.fromValue = @1;
    scale.toValue = @0;
    [menuButtons enumerateObjectsUsingBlock:^(PNRadialMenuButton *menuButton, NSUInteger idx, BOOL *stop) {
        if (menuButton != selectedMenuButton) {
            [menuButton.layer addAnimation:scale forKey:@"shrinkToZero"];
            menuButton.layer.transform = CATransform3DMakeScale(0, 0, 0);
        }
    }];
}

- (void)animationDidStart:(CAAnimation *)anim
{
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    // FIXME: This is hacky
    self.isAnimating = NO;
    
    if (self.menuIsDisplayed) {
        self.menuIsDisplayed = NO;
        
        self.modalView.hidden = YES;
        [self.menuButtons enumerateObjectsUsingBlock:^(PNRadialMenuButton *menuButton, NSUInteger idx, BOOL *stop) {
            menuButton.hidden = YES;
            menuButton.layer.position = self.mainButton.layer.position;
            menuButton.layer.transform = CATransform3DIdentity;
            menuButton.layer.opacity = 1.0;
        }];
    } else {
        self.menuIsDisplayed = YES;
    }
}

@end
