//
//  GDUILabelInsetViewController.m
//  UIKitDemo
//
//  Created by lingjing on 2019/8/28.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "GDUILabelInsetViewController.h"
#import <Masonry/Masonry.h>

@interface GDUILabel : UILabel

@end

@implementation GDUILabel

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
}

@end

@interface GDUILabelInsetViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation GDUILabelInsetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height);
    [self.view addSubview:self.scrollView];
    
    UIView *leftView;
    UIView *rightView;
    for (int i=8; i<=36; i++) {
        UILabel *zhLabel = [[GDUILabel alloc] init];
        zhLabel.font = [UIFont systemFontOfSize:i];
        zhLabel.backgroundColor = [UIColor purpleColor];
        zhLabel.textColor = [UIColor whiteColor];
        zhLabel.text = [NSString stringWithFormat:@"%d:中文&Chinese", i];
        [self.scrollView addSubview:zhLabel];
        [zhLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.scrollView).offset(16);
            if (leftView) {
                make.top.equalTo(leftView.mas_bottom).offset(8);
            } else {
                make.top.equalTo(self.scrollView).offset(88+28);
            }
            if (i==36) {
                make.bottom.equalTo(self.scrollView).offset(-16);
            }
        }];
        
        UILabel *numberLabel = [[UILabel alloc] init];
        numberLabel.font = [UIFont systemFontOfSize:i];
        numberLabel.text = [NSString stringWithFormat:@"%d:012abABg", i];
        numberLabel.backgroundColor = [UIColor grayColor];
        numberLabel.textColor = [UIColor whiteColor];
        numberLabel.textAlignment = NSTextAlignmentRight;
        [self.scrollView addSubview:numberLabel];
        [numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.view).offset(-16);
            if (rightView) {
                make.top.equalTo(leftView.mas_bottom).offset(8);
            } else {
                make.top.equalTo(self.scrollView).offset(88+28);
            }
        }];
        leftView = zhLabel;
        rightView = numberLabel;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
