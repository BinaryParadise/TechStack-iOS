//
//  GDUIViewController.m
//  UIKitDemo
//
//  Created by Rake Yang on 2019/10/22.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "GDUIViewController.h"
#import "GDDemoView.h"

@interface GDUIViewController ()

@property (nonatomic, weak) IBOutlet GDDemoView *dview;
@property (nonatomic, weak) IBOutlet UISlider *sliderX;
@property (nonatomic, weak) IBOutlet UISlider *sliderY;

@end

@implementation GDUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    GDDemoView *demoView = [[GDDemoView alloc] init];
    [demoView setNeedsLayout];
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];    
}

- (IBAction)sliderValueChanged:(UISlider *)slider {
    CGRect bounds = self.dview.bounds;
    if (slider == self.sliderX) {
        bounds.origin.x = slider.value;
    } else {
        bounds.origin.y = slider.value;
    }
    self.dview.bounds = bounds;
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
