//
//  GDNormalView.m
//  UIKitDemo
//
//  Created by Rake Yang on 2019/12/10.
//  Copyright © 2019年 BinaryParadise. All rights reserved.
//

#import "GDNormalView.h"
#define radians(angle) ((angle) / 180.0 * M_PI)

@interface GDNormalView ()
    
@property (nonatomic, strong) CAShapeLayer *shapeLayer;


@end

@implementation GDNormalView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [self.shapeLayer removeFromSuperlayer];
    
    CGFloat x = 0;
    CGFloat w = rect.size.width * 0.25;
    CGFloat radius = rect.size.width / 4.0;
    CGFloat offset = rect.size.width / 3.0 - rect.size.width/4;
    CGFloat y = 0;
    
    self.shapeLayer = [CAShapeLayer layer];
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(x + radius, y + radius) radius:radius startAngle:radians(160) endAngle:radians(340) clockwise:YES];
    [bezierPath addArcWithCenter:CGPointMake(x + radius * 3 - offset/2.0, y + radius - offset*2) radius:radius startAngle:radians(160) endAngle:radians(20) clockwise:NO];
    [bezierPath addArcWithCenter:CGPointMake(x + radius * 3, y + radius) radius:radius startAngle:radians(160) endAngle:radians(0) clockwise:YES];
    [bezierPath addArcWithCenter:CGPointMake(x + radius, y + radius) radius:radius startAngle:radians(160) endAngle:radians(0) clockwise:NO];
    
    self.shapeLayer.strokeColor = self.tintColor.CGColor;
    self.shapeLayer.fillColor = self.backgroundColor.CGColor;
    self.shapeLayer.path = bezierPath.CGPath;
    [self.layer addSublayer:self.shapeLayer];
}

@end
