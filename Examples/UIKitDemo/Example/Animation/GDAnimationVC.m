//
//  GDAnimationVC.m
//  UIKitDemo
//
//  Created by Rake Yang on 2019/11/24.
//  Copyright © 2019年 BinaryParadise. All rights reserved.
//

#import "GDAnimationVC.h"
#import <MCUIKit/UIView+MCFrameGeometry.h>
#define radians(angle) ((angle) / 180.0 * M_PI)

@interface GDAnimationVC () <CAAnimationDelegate>

@property (nonatomic, weak) IBOutlet UIView *normalView;
@property (nonatomic, weak) IBOutlet UIView *keyFrameView;

@end

@implementation GDAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self animationDidStop:nil finished:YES];
    // Do any additional setup after loading the view.
    switch (self.type) {
        case 1:
            [self custom:self.normalView];
            break;
        case 2:
            [self keyFrame:self.keyFrameView];
            break;
        default:
            [self normal:self.normalView];
            break;
    }
}

/**
 标准动画
 */
- (void)normal:(UIView *)view {
    [UIView animateWithDuration:3 animations:^{
        view.mcLeft = self.view.mcRight;
    } completion:^(BOOL finished) {
        [self animationDidStop:nil finished:finished];
    }];
}

/**
 自定义动画
 */
- (void)custom:(UIView *)view {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.duration = 3.0;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(-view.mcWidth, view.mcTop)];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.view.mcRight+view.mcWidth, view.mcTop)];
    animation.delegate = self;
    
    [self.normalView.layer addAnimation:animation forKey:@"move"];
}

/**
 关键帧
 */
- (void)keyFrame:(UIView *)view {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.duration = 6.0;
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    animation.delegate = self;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.fillMode = kCAFillModeForwards;
    animation.calculationMode = kCAAnimationPaced;
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    CGFloat y = view.mcTop + view.mcHeight/2.0;
    CGFloat radius = (self.view.mcWidth-60)/4.0;
    [path moveToPoint:CGPointMake(30, y)];
    [path addArcWithCenter:CGPointMake(30+radius, y) radius:radius startAngle:radians(180) endAngle:radians(0) clockwise:YES];
    [path addArcWithCenter:CGPointMake(30+radius*3, y) radius:radius startAngle:radians(180) endAngle:radians(-180) clockwise:NO];
    [path addArcWithCenter:CGPointMake(30+radius, y) radius:radius startAngle:radians(0) endAngle:radians(180) clockwise:YES];
    animation.path = path.CGPath;
    
    [view.layer addAnimation:animation forKey:@"move"];
}

#pragma mark - CAAnimationDelegate

- (void)animationDidStart:(CAAnimation *)anim {
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    self.normalView.mcLeft = -self.normalView.mcWidth;
}

@end
