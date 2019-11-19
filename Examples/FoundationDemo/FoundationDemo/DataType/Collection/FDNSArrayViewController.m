//
//  FDNSArrayViewController.m
//  FoundationDemo
//
//  Created by Rake Yang on 2019/11/19.
//  Copyright © 2019年 BinaryParadise. All rights reserved.
//

#import "FDNSArrayViewController.h"
#import "../../View/UITableViewCell+MCRegister.h"
#import <MCUIKit/UIColor+MCExtension.h>

@interface FDNSArrayTableViewCell : UITableViewCell

@end

@implementation FDNSArrayTableViewCell


@end

@interface FDNSArrayViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *data;

@end

@implementation FDNSArrayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.data = [NSMutableArray array];
    for (int i=0; i< 88; i++) {
        [self.data addObject:[NSDate date]];
    }
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.5 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSInteger idx = arc4random() % self.data.count;
        if (idx%2 == 0) {
            [self.data removeObjectAtIndex:idx];
            [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:idx inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
        } else {
            [self.data replaceObjectAtIndex:idx withObject:[NSDate date]];
            [self reloadData:[NSIndexPath indexPathForRow:idx inSection:0]];
        }
    }];
    [timer fire];
    [self reloadData:nil];
}

- (void)reloadData:(NSIndexPath *)indexPath {
    [self.data sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj2 compare:obj1];
    }];
    if (indexPath) {
        [self.tableView moveRowAtIndexPath:indexPath toIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    } else {
        [self.tableView reloadData];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FDNSArrayTableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"FDNSArrayTableViewCell"];
        cell.textLabel.textColor = [UIColor whiteColor];
    }
    NSDate *date = self.data[indexPath.row];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"yyyy-MM-dd HH:mm:ss.SSS";
    cell.textLabel.text = [df stringFromDate:date];
    cell.backgroundColor = indexPath.row % 2 == 0 ? MCHexColor(0xE11900) : MCHexColor(0x7e00bf);
    return cell;
}

@end
