//
//  PNRadialMenu.m
//  PNRadialMenu
//
//  Created by Philip Nichols on 8/27/14.
//  Copyright (c) 2014 Phil Nichols. All rights reserved.
//

#import "PNRadialMenu.h"
#import "PNRadialMenuMainButton.h"
#import "PNRadialMenuButton.h"

#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

@interface PNRadialMenu ()

@property (strong, nonatomic) PNRadialMenuMainButton *mainButton;
@property (strong, nonatomic) NSMutableArray *menuButtons; // of PNRadialMenuButton

@property (weak,   nonatomic) UIView *superview;    // View that the radial menu will be parented to.
@property (strong, nonatomic) UIView *parentView;   // Supplemental view that serves as the parent view for all the components of the radial menu.
@property (strong, nonatomic) UIView *modalView;

@property (nonatomic, readwrite, getter = isAnimating) BOOL animating;
@property (nonatomic, readwrite, getter = isDisplayed) BOOL displayed;

@end

@implementation PNRadialMenu

#pragma mark - Initialization

- (instancetype)init
{
    NSAssert(NO, @"'init' is not supported. Please use one of the designated initializers or a convenience initializer");
    return nil;
}

- (instancetype)initInView:(UIView *)view
{
    self = [super init];
    if (self) {
        self.superview = view;
        [self.superview addSubview:self.parentView];

        [self.parentView addSubview:self.modalView];
        
        self.duration = 0.5;
        self.center = CGPointZero;
        self.arcSize = 180.0;
        self.startAngle = -90.0;
        self.horizontalRadius = 100.0;
        self.verticalRadius = 100.0;
        self.centeredArc = NO;
    }
    return self;
}

+ (instancetype)radialMenuInView:(UIView *)view
{
    return [[PNRadialMenu alloc] initInView:view];
}

#pragma mark - Properties

- (NSMutableArray *)menuButtons
{
    if (!_menuButtons) {
        _menuButtons = [NSMutableArray array];
    }
    return _menuButtons;
}

- (UIView *)parentView
{
    if (!_parentView) {
        _parentView = [[UIControl alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _parentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return _parentView;
}

- (UIView *)modalView {
    if (!_modalView) {
        _modalView = [[UIControl alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _modalView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _modalView.backgroundColor = [UIColor blackColor];
        _modalView.layer.opacity = 0.0;
        _modalView.hidden = YES;
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(overlayViewTapped:)];
        [_modalView addGestureRecognizer:tapGestureRecognizer];
    }
    return _modalView;
}

- (void)setMainButton:(PNRadialMenuMainButton *)mainButton
{
    [_mainButton removeFromSuperview];
    
    _mainButton = mainButton;
}

- (void)setCenter:(CGPoint)center
{
    _center = center;
    
    self.mainButton.center = _center;
    [self.menuButtons enumerateObjectsUsingBlock:^(PNRadialMenuButton *menuButton, NSUInteger idx, BOOL *stop) {
        menuButton.center = _center;
    }];
}

#pragma mark - Configuration

- (void)configureMainButtonWithFrame:(CGRect)frame
{
    self.mainButton = [[PNRadialMenuMainButton alloc] initWithFrame:frame];
    self.mainButton.center = self.center;
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mainButtonTapped:)];
    [self.mainButton addGestureRecognizer:tapGestureRecognizer];
    
    [self.parentView addSubview:self.mainButton];
}

- (void)addMenuButtonWithFrame:(CGRect)frame color:(UIColor *)color image:(UIImage *)image text:(NSString *)text
{
    [self.mainButton removeFromSuperview];
    
    PNRadialMenuButton *menuButton = [[PNRadialMenuButton alloc] initWithFrame:frame
                                                                         color:color
                                                                         image:image
                                                                          text:text];
    menuButton.center = self.center;
    menuButton.hidden = YES;
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(menuButtonTapped:)];
    [menuButton addGestureRecognizer:tapGestureRecognizer];
    
    [self.menuButtons addObject:menuButton];
    [self.parentView addSubview:menuButton];
    
    [self.parentView addSubview:self.mainButton];
}

#pragma mark - Actions

- (void)overlayViewTapped:(UITapGestureRecognizer *)tapGestureRecognizer
{
    [self animateTogglePresentAndDismissRadialMenu];
}

- (void)mainButtonTapped:(UITapGestureRecognizer *)tapGestureRecognizer
{
    [self animateTogglePresentAndDismissRadialMenu];
}

- (void)menuButtonTapped:(UITapGestureRecognizer *)tapGestureRecognizer
{
    if (!self.isAnimating) {
        self.animating = YES;
        
        [self animateModalDismiss];
        [self animateMainButtonClose];
        [self animateMenuButtonsSelect:(PNRadialMenuButton *)tapGestureRecognizer.view];
        [self animateMenuButtonsNoSelect:self.menuButtons exclude:(PNRadialMenuButton *)tapGestureRecognizer.view];
    }
}

#pragma mark - Animations

- (void)animateTogglePresentAndDismissRadialMenu
{
    if (!self.isAnimating) {
        if (self.isDisplayed) {
            self.animating = YES;
            
            [self animateModalDismiss];
            
            [self animateMainButtonClose];
            
            [self animateMenuButtonsDismiss];
        } else {
            self.animating = YES;
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
    rotateAnimation.duration = self.duration;
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
    rotateAnimation.duration = self.duration;
    rotateAnimation.fromValue = @(DEGREES_TO_RADIANS(-45));
    rotateAnimation.toValue = @(DEGREES_TO_RADIANS(0));
    rotateAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    rotateAnimation.delegate = self;
    
    [self.mainButton.layer addAnimation:rotateAnimation forKey:@"rotate45"];
    self.mainButton.layer.transform = CATransform3DMakeRotation(DEGREES_TO_RADIANS(0), 0, 0, 1);
}

- (void)animateModalDisplay
{
    CABasicAnimation *opactiyAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opactiyAnimation.duration = self.duration;
    opactiyAnimation.fromValue = @0.0;
    opactiyAnimation.toValue = @0.75;
    opactiyAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [self.modalView.layer addAnimation:opactiyAnimation forKey:@"transparentToOpaque"];
    self.modalView.layer.opacity = 0.75;
}

- (void)animateModalDismiss
{
    CABasicAnimation *opactiyAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opactiyAnimation.duration = self.duration;
    opactiyAnimation.fromValue = @0.75;
    opactiyAnimation.toValue = @0.0;
    opactiyAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [self.modalView.layer addAnimation:opactiyAnimation forKey:@"opaqueToTransparent"];
    self.modalView.layer.opacity = 0.0;
}

- (void)animateMenuButtonsDisplay
{
    CGFloat startAngle = self.isCenteredArc ? 90 - (self.arcSize / 2) : self.startAngle;
    CGFloat angleBetweenButtons = (self.arcSize >= 360) ? (360 / [self.menuButtons count]) : (([self.menuButtons count] > 1) ? (self.arcSize / ([self.menuButtons count] - 1)) : 0.0);
    
    CABasicAnimation *position = [CABasicAnimation animationWithKeyPath:@"position"];
    position.duration = self.duration;
    position.fromValue = [NSValue valueWithCGPoint:self.mainButton.layer.position];
    position.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.82 :1.69 :0.11 :0.61];
    
    CABasicAnimation *opacity = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacity.duration = self.duration * 0.4;
    opacity.fromValue = @0.0;
    opacity.toValue = @1.0;
    
    [self.menuButtons enumerateObjectsUsingBlock:^(PNRadialMenuButton *menuButton, NSUInteger idx, BOOL *stop) {
        CGFloat radians = DEGREES_TO_RADIANS(startAngle + (angleBetweenButtons * idx));
        CGFloat x = -self.horizontalRadius * cos(radians);
        CGFloat y = -self.verticalRadius * sin(radians);
        
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
    position.duration = self.duration;
    position.toValue = [NSValue valueWithCGPoint:self.mainButton.layer.position];
    position.timingFunction = [CAMediaTimingFunction functionWithControlPoints:1.0 :-0.07 :0.86 :-0.24];
    
    CABasicAnimation *opacity = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacity.duration = self.duration * 0.4;
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
    scale.duration = self.duration;
    scale.fromValue = @1;
    scale.toValue = @2;
    [menuButton.layer addAnimation:scale forKey:@"scaleTimes3"];
    menuButton.layer.transform = CATransform3DMakeScale(2, 2, 0);
    
    CABasicAnimation *fade = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fade.duration = self.duration;
    fade.fromValue = @1;
    fade.toValue = @0;
    [menuButton.layer addAnimation:fade forKey:@"fadeToNothing"];
    menuButton.layer.opacity = 0.0;
}

- (void)animateMenuButtonsNoSelect:(NSArray *)menuButtons exclude:(PNRadialMenuButton *)selectedMenuButton
{
    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scale.duration = self.duration;
    scale.fromValue = @1;
    scale.toValue = @0;
    [menuButtons enumerateObjectsUsingBlock:^(PNRadialMenuButton *menuButton, NSUInteger idx, BOOL *stop) {
        if (menuButton != selectedMenuButton) {
            [menuButton.layer addAnimation:scale forKey:@"shrinkToZero"];
            menuButton.layer.transform = CATransform3DMakeScale(0, 0, 0);
        }
    }];
}

#pragma mark - CAAnimationDelegate

- (void)animationDidStart:(CAAnimation *)anim
{
    if (!self.isDisplayed) {
        // Put the parent view on top of all other views
        [self.parentView removeFromSuperview];
        
        NSEnumerator *frontToBackWindows = [[[UIApplication sharedApplication] windows] reverseObjectEnumerator];
        
        for (UIWindow *window in frontToBackWindows) {
            if (window.windowLevel == UIWindowLevelNormal) {
                [window addSubview:self.parentView];
                break;
            }
        }
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (self.displayed) {
        // Put the parent view back to it's original superview
        [self.parentView removeFromSuperview];
        [self.superview addSubview:self.parentView];
    }
    
    // FIXME: This is hacky
    self.animating = NO;
    
    if (self.isDisplayed) {
        self.displayed = NO;
        
        [self.menuButtons enumerateObjectsUsingBlock:^(PNRadialMenuButton *menuButton, NSUInteger idx, BOOL *stop) {
            menuButton.hidden = YES;
            menuButton.layer.position = self.mainButton.layer.position;
            menuButton.layer.transform = CATransform3DIdentity;
            menuButton.layer.opacity = 1.0;
        }];
    } else {
        self.displayed = YES;
    }
}

@end
