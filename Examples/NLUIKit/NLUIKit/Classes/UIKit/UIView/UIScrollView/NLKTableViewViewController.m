//
//  NLKTableViewViewController.m
//  NLUIKit
//
//  Created by Rake Yang on 2020/6/8.
//

#import "NLKTableViewViewController.h"

static dispatch_semaphore_t sema;

@interface _NLKMsgCell : UITableViewCell

@property (nonatomic, strong) UILabel *msgLabel;

@end

@implementation _NLKMsgCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.msgLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 8, 100, 20)];
        self.msgLabel.layer.cornerRadius = 10;
        self.msgLabel.layer.masksToBounds = YES;
        self.msgLabel.font = [UIFont systemFontOfSize:15];
        self.msgLabel.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.15];
        [self.contentView addSubview:self.msgLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.msgLabel sizeToFit];
}

@end

@interface NLKTableViewViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *marr;


@end

@implementation NLKTableViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    sema = dispatch_semaphore_create(1);
    
    self.marr = [NSMutableArray array];
    // Do any additional setup after loading the view.
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"开始" style:UIBarButtonItemStyleDone target:self action:@selector(startAction:)];
}

- (void)startAction:(id)sender {
    for (int i=0; i<1; i++) {
        dispatch_queue_t queue = dispatch_queue_create([NSString stringWithFormat:@"queue-%d", i].UTF8String, DISPATCH_QUEUE_SERIAL);
        for (int x=0; x<200; x++) {
            dispatch_async(queue, ^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self appendRow:i y:x];
                });
            });
        }
    }
}

- (void)appendRow:(int)x y:(int)y {
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    NSMutableArray *deletes = [NSMutableArray array];
    if (self.marr.count >= 100) {
        NSLog(@"range");
        [self.marr removeObjectsInRange:NSMakeRange(0, 50)];
        for (int i=0; i<50; i++) {
            [deletes addObject:[NSIndexPath indexPathForRow:i inSection:0]];
        }
    }
    [self.marr addObject:[NSString stringWithFormat:@" x:%d y:%d t:%lu ", x, y, self.marr.count]];
    [self.tableView beginUpdates];
    if (deletes.count) {
        [self.tableView deleteRowsAtIndexPaths:deletes withRowAnimation:UITableViewRowAnimationBottom];
    }
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.marr.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationBottom];
    [self.tableView endUpdates];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.marr.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    dispatch_semaphore_signal(sema);
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.marr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _NLKMsgCell *cell = [tableView dequeueReusableCellWithIdentifier:@"scell"];
    if (!cell) {
        cell = [[_NLKMsgCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"scell"];
    }
    cell.msgLabel.text = [self.marr objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate


@end
