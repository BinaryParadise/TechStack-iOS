//
//  GDLoadingView.m
//  UIKitDemo
//
//  Created by Rake Yang on 2019/6/15.
//  Copyright © 2019年 BinaryParadise. All rights reserved.
//

#import "GDLoadingView.h"

#define radians(angle) ((angle) / 180.0 * M_PI)

@interface GDLoadingView ()

@property (nonatomic, strong) CAShapeLayer *gossipLayer;

@end

@implementation GDLoadingView

- (CAAnimationGroup *)animationWithStartTime:(CFTimeInterval)start {
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.duration = 1.5f;
    opacityAnimation.repeatCount = MAXFLOAT;
    opacityAnimation.fromValue = @(1.0);
    opacityAnimation.toValue = @(0.0);
    opacityAnimation.beginTime = start;
    return opacityAnimation;
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.duration = 2.0f;
    scaleAnimation.repeatCount = MAXFLOAT;
    scaleAnimation.fromValue = @(1.0);
    scaleAnimation.toValue = @(3.0);
    scaleAnimation.beginTime = start;
    
    CABasicAnimation *positionAnimation =
    [CABasicAnimation animationWithKeyPath:@"position"];
    positionAnimation.duration = 1.0f;
    positionAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(0, -128)];

    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = 1.0;
    group.repeatCount = MAXFLOAT;
    group.animations = @[opacityAnimation];
    return group;
}

/**
 乾
 */
- (void)drawQian:(CGRect)rect {
    CGFloat w = rect.size.width * 0.25;
    CGFloat radius = rect.size.width *0.5 / 2.0;
    
    CAShapeLayer *qianLayer = [CAShapeLayer layer];
    
    CGFloat sx = w;
    CGFloat sy = 0;
    
    UIBezierPath *trapezoid1Path = [UIBezierPath bezierPath];
    [trapezoid1Path moveToPoint:CGPointMake(sx + radius, sy + 0.2*radius)];
    [trapezoid1Path addLineToPoint:CGPointMake(sx + 1.7*radius, sy + 0.2*radius)];
    [trapezoid1Path addLineToPoint:CGPointMake(sx + 1.8*radius, sy)];
    [trapezoid1Path addLineToPoint:CGPointMake(sx + 0.1*radius, sy)];
    [trapezoid1Path addLineToPoint:CGPointMake(sx + 0.2*radius, sy + 0.2*radius)];
    [trapezoid1Path addLineToPoint:CGPointMake(sx + radius, sy + 0.2*radius)];
    CAShapeLayer *trapezoid1Layer = [CAShapeLayer layer];
    trapezoid1Layer.path = trapezoid1Path.CGPath;
    trapezoid1Layer.lineWidth = 0;
    trapezoid1Layer.fillColor = [UIColor blackColor].CGColor;
    [self.layer addSublayer:trapezoid1Layer];
    
    sx += 0.1*radius;
    sy += 0.2*radius + 5;
    UIBezierPath *trapezoid2Path = [UIBezierPath bezierPath];
    [trapezoid2Path moveToPoint:CGPointMake(sx + radius, sy + 0.2*radius)];
    [trapezoid2Path addLineToPoint:CGPointMake(sx + 1.5*radius, sy + 0.2*radius)];
    [trapezoid2Path addLineToPoint:CGPointMake(sx + 1.6*radius, sy)];
    [trapezoid2Path addLineToPoint:CGPointMake(sx + 0.1*radius, sy)];
    [trapezoid2Path addLineToPoint:CGPointMake(sx + 0.2*radius, sy + 0.2*radius)];
    [trapezoid2Path addLineToPoint:CGPointMake(sx + radius, sy + 0.2*radius)];
    CAShapeLayer *trapezoid2Layer = [CAShapeLayer layer];
    trapezoid2Layer.path = trapezoid2Path.CGPath;
    trapezoid2Layer.lineWidth = 0;
    trapezoid2Layer.fillColor = [UIColor blackColor].CGColor;
    [self.layer addSublayer:trapezoid2Layer];
    
    sx += 0.1*radius;
    sy += 0.2*radius + 5;
    UIBezierPath *trapezoid3Path = [UIBezierPath bezierPath];
    [trapezoid3Path moveToPoint:CGPointMake(sx + radius, sy + 0.2*radius)];
    [trapezoid3Path addLineToPoint:CGPointMake(sx + 1.3*radius, sy + 0.2*radius)];
    [trapezoid3Path addLineToPoint:CGPointMake(sx + 1.4*radius, sy)];
    [trapezoid3Path addLineToPoint:CGPointMake(sx + 0.1*radius, sy)];
    [trapezoid3Path addLineToPoint:CGPointMake(sx + 0.2*radius, sy + 0.2*radius)];
    [trapezoid3Path addLineToPoint:CGPointMake(sx + radius, sy + 0.2*radius)];
    CAShapeLayer *trapezoid3Layer = [CAShapeLayer layer];
    trapezoid3Layer.path = trapezoid3Path.CGPath;
    trapezoid3Layer.lineWidth = 0;
    trapezoid3Layer.fillColor = [UIColor blackColor].CGColor;
    [self.layer addSublayer:trapezoid3Layer];
    
    [trapezoid3Layer addAnimation:[self animationWithStartTime:0.0] forKey:@"opacity"];
    [trapezoid2Layer addAnimation:[self animationWithStartTime:0.2] forKey:@"opacity"];
    [trapezoid1Layer addAnimation:[self animationWithStartTime:0.5] forKey:@"opacity"];
}

- (void)drawRect:(CGRect)rect {
    [self.gossipLayer removeFromSuperlayer];
    
    CGFloat x = rect.size.width*0.25;
    CGFloat radius = rect.size.width*0.5 / 2;
    
    self.gossipLayer = [CAShapeLayer layer];
    self.gossipLayer.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(x + radius, x + radius) radius:radius startAngle:radians(0) endAngle:radians(360) clockwise:YES].CGPath;
    
    //白色区
    UIBezierPath *whitePath = [UIBezierPath bezierPath];
    [whitePath addArcWithCenter:CGPointMake(x + radius, x + radius) radius:radius startAngle:radians(90) endAngle:radians(270) clockwise:YES];
    [whitePath addArcWithCenter:CGPointMake(x + radius, x + radius/2) radius:radius/2 startAngle:radians(270) endAngle:radians(450) clockwise:YES];
    [whitePath addArcWithCenter:CGPointMake(x + radius, x + 3/4.0*radius*2) radius:radius/2 startAngle:radians(270) endAngle:radians(90) clockwise:NO];
    [whitePath closePath];
    
    CAShapeLayer *shapeLayer1 = [CAShapeLayer layer];
    shapeLayer1.path = whitePath.CGPath;
    shapeLayer1.lineWidth = 1/[UIScreen mainScreen].scale;
    shapeLayer1.strokeColor = self.tintColor.CGColor;
    shapeLayer1.fillColor = [UIColor whiteColor].CGColor;
    [self.gossipLayer addSublayer:shapeLayer1];
    
    //黑色区
    UIBezierPath *blackPath = [UIBezierPath bezierPath];
    [blackPath addArcWithCenter:CGPointMake(x + radius, x + radius) radius:radius startAngle:radians(90) endAngle:radians(270) clockwise:NO];
    [blackPath addArcWithCenter:CGPointMake(x + radius, x + radius/2) radius:radius/2 startAngle:radians(270) endAngle:radians(450) clockwise:YES];
    [blackPath addArcWithCenter:CGPointMake(x + radius, x + 3/4.0*radius*2) radius:radius/2 startAngle:radians(270) endAngle:radians(90) clockwise:NO];
    [blackPath closePath];
    
    CAShapeLayer *shapeLayer2 = [CAShapeLayer layer];
    shapeLayer2.path = blackPath.CGPath;
    shapeLayer2.lineWidth = 1/[UIScreen mainScreen].scale;
    shapeLayer2.strokeColor = self.tintColor.CGColor;
    shapeLayer2.fillColor = [UIColor blackColor].CGColor;
    [self.gossipLayer addSublayer:shapeLayer2];
    
    //小黑圆
    UIBezierPath *mBlackPath = [UIBezierPath bezierPath];
    [mBlackPath addArcWithCenter:CGPointMake(x + radius, x + radius / 2) radius:1/6.0 * radius startAngle:0 endAngle:radians(360) clockwise:YES];
    [mBlackPath closePath];
    CAShapeLayer *mshapeLayer1 = [CAShapeLayer layer];
    mshapeLayer1.path = mBlackPath.CGPath;
    mshapeLayer1.lineWidth = 1/[UIScreen mainScreen].scale;
    mshapeLayer1.strokeColor = [UIColor blackColor].CGColor;
    mshapeLayer1.fillColor = [UIColor blackColor].CGColor;
    [self.gossipLayer addSublayer:mshapeLayer1];
    
    //小白圆
    UIBezierPath *mWhitePath = [UIBezierPath bezierPath];
    [mWhitePath addArcWithCenter:CGPointMake(x + radius, x + radius * 3/2.0) radius:1/6.0 * radius startAngle:0 endAngle:radians(360) clockwise:YES];
    [mWhitePath closePath];
    CAShapeLayer *mshapeLayer2 = [CAShapeLayer layer];
    mshapeLayer2.path = mWhitePath.CGPath;
    mshapeLayer2.lineWidth = 1/[UIScreen mainScreen].scale;
    mshapeLayer2.strokeColor = [UIColor whiteColor].CGColor;
    mshapeLayer2.fillColor = [UIColor whiteColor].CGColor;
    [self.gossipLayer addSublayer:mshapeLayer2];
    
    [self drawQian:rect];
    
    CABasicAnimation *circleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    circleAnimation.duration = 2.0f;
    circleAnimation.repeatCount = MAXFLOAT;
    circleAnimation.toValue = @(M_PI*2);
    circleAnimation.cumulative = YES;
    
    [self.layer addSublayer:self.gossipLayer];
    //[self.layer addAnimation:circleAnimation forKey:@"rotation"];
}

@end
