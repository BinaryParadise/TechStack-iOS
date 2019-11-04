//
//  FDAttributeLabel.m
//  FoundationDemo
//
//  Created by Rake Yang on 2019/11/7.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "FDAttributeLabel.h"

@implementation FDAttributeLabel

- (void)setText:(NSString *)text {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 4;
    paragraphStyle.minimumLineHeight = 20;
    
    NSMutableAttributedString *mattr = [[NSMutableAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName: self.font, NSForegroundColorAttributeName: self.textColor, NSParagraphStyleAttributeName:paragraphStyle}];
    [self extractEmotions:mattr];
    self.attributedText = mattr;
}

- (void)extractEmotions:(NSMutableAttributedString *)mattr {
    NSString *originStr = mattr.string;
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:@"\\[[\\u4e00-\\u9fa5]\\]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray<NSTextCheckingResult *> *matches = [regular matchesInString:originStr options:NSMatchingWithoutAnchoringBounds range:NSMakeRange(0, mattr.string.length)];
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle].bundlePath stringByAppendingString:@"/Emotions.bundle"]];
    [matches.reverseObjectEnumerator.allObjects enumerateObjectsUsingBlock:^(NSTextCheckingResult * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *phrase = [originStr substringWithRange:obj.range];
        NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
        attachment.image = [UIImage imageNamed:[phrase stringByAppendingString:@".png"] inBundle:bundle compatibleWithTraitCollection:nil];
        if (!attachment.image) {
            attachment.image = [UIImage imageNamed:[phrase stringByAppendingString:@".gif"] inBundle:bundle compatibleWithTraitCollection:nil];
        }
        CGFloat imgH = attachment.image.size.height * 20.0 /attachment.image.size.width;
        attachment.bounds = CGRectMake(0, -4, 20, imgH);
        NSAttributedString *attr = [NSAttributedString attributedStringWithAttachment:attachment];
        [mattr replaceCharactersInRange:obj.range withAttributedString:attr];
    }];
}

@end
