//
//  NLWBAccountView.m
//  NLWeibo
//
//  Created by Rake Yang on 2019/12/4.
//

#import "NLWBAccountView.h"
#import <Masonry/Masonry.h>

@interface NLWBAccountView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) WBAccountViewModel *viewModel;
@property (nonatomic, strong) UITableView *tableView;


@end

@implementation NLWBAccountView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        self.tableView.backgroundColor = self.backgroundColor;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:self.tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}

- (void)fillWithViewModel:(WBAccountViewModel *)viewModel {
    _viewModel = viewModel;
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.items.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    if (indexPath.row == self.viewModel.items.count) {
        cell.textLabel.text = @"退出";
    } else {
        NLKeyValue *kv = [self.viewModel.items objectAtIndex:indexPath.row];
        cell.textLabel.text = kv.value;
        cell.detailTextLabel.text = kv.key;
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.viewModel.items.count) {
        if ([self.delegate respondsToSelector:@selector(willClearAuthData)]) {
            [self.delegate willClearAuthData];
        }
    }
}

@end
