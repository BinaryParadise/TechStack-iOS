
//
//  NLVPSManageViewController.m
//  Neverland
//
//  Created by Rake Yang on 2020/3/1.
//  Copyright © 2020 BinaryParadise. All rights reserved.
//

#import "NLVPSManageViewController.h"
#import "NLVPSInfoTableViewCell.h"
#import <SAMKeychain/SAMKeychain.h>
#import <MCJSONKit/MCJSONKit.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import <Toast/Toast.h>

#define kKeyChainServiceName    @"neverland.life"
#define FMT(fmt, ...) [NSString stringWithFormat:fmt, ##__VA_ARGS__]

@interface NLInfoModel : NSObject

@property (nonatomic, copy) NSString *vm_type;
@property (nonatomic, copy) NSString *hostname;
@property (nonatomic, copy) NSString *node_ip;
@property (nonatomic, copy) NSString *node_alias;
@property (nonatomic, copy) NSString *node_location;
@property (nonatomic, copy) NSString *node_location_id;
@property (nonatomic, copy) NSString *node_datacenter;
@property (nonatomic, assign) BOOL location_ipv6_ready;
@property (nonatomic, copy) NSString *plan;
@property (nonatomic, assign) long plan_monthly_data;
@property (nonatomic, assign) NSInteger monthly_data_multiplier;
@property (nonatomic, assign) long plan_disk;
@property (nonatomic, assign) long plan_ram;
@property (nonatomic, assign) long plan_swap;
@property (nonatomic, copy) NSString *plan_max_ipv6s;
@property (nonatomic, copy) NSString *os;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, assign) long data_counter;
@property (nonatomic, assign) NSTimeInterval data_next_reset;
@property (nonatomic, copy) NSArray<NSString *> *ip_addresses;
@property (nonatomic, assign) BOOL plan_private_network_available;
@property (nonatomic, assign) BOOL location_private_network_available;
@property (nonatomic, assign) BOOL rdns_api_available;
@property (nonatomic, assign) BOOL suspended;
@property (nonatomic, assign) BOOL policy_violation;
@property (nonatomic, assign) NSInteger max_abuse_points;
@property (nonatomic, assign) NSInteger error;

@end

@implementation NLInfoModel



@end

@interface NLVPSManageViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *data;

@end

@implementation NLVPSManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [CSToastManager setDefaultPosition:CSToastPositionCenter];
    
    self.title = @"BWG";
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"NLVPSInfoTableViewCell" bundle:nil] forCellReuseIdentifier:@"InfoCell"];
    
    NSString *veid = [SAMKeychain passwordForService:kKeyChainServiceName account:@"veid"];
    NSString *api_key = [SAMKeychain passwordForService:kKeyChainServiceName account:@"api_key"];
    
    NSString *url = [NSString stringWithFormat:@"https://api.64clouds.com/v1/getServiceInfo?veid=%@&api_key=%@", veid, api_key];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [UIApplication.sharedApplication setNetworkActivityIndicatorVisible:YES];
    __weak typeof(self) self__weak = self;
    NSURLSessionDataTask *task = [NSURLSession.sharedSession dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            __strong typeof(self__weak) self = self__weak;
            [UIApplication.sharedApplication setNetworkActivityIndicatorVisible:NO];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if (error) {
                [self.view makeToast:error.localizedDescription];
            } else {
                if (data) {
                    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"CacheData"];
                }
                [self processData:data];
            }

        });
    }];
    [task resume];
    
    [self processData:[[NSUserDefaults standardUserDefaults] dataForKey:@"CacheData"]];
}

- (void)processData:(NSData *)data {
    if (!data) {
        [self.view makeToast:@"数据解析失败"];
        return;
    }
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    NLInfoModel *info = [NLInfoModel mc_objectFromKeyValues:dict];
    self.title = info.ip_addresses.firstObject;
    NSDateFormatter *fmt = [NSDateFormatter new];
    fmt.dateFormat = @"yyyy-MM-dd";
    self.data = @[@[@"类型",info.vm_type],
                  @[@"主机名",info.hostname],
                  @[@"节点IP",info.node_ip],
                  @[@"节点别名",info.node_alias],
                  @[@"节点地址",info.node_location],
                  @[@"节点编号",info.node_location_id],
                  @[@"数据中心",info.node_datacenter],
                  @[@"IPV6",info.location_ipv6_ready?@"支持":@"不支持"],
                  @[@"计划",info.plan],
                  @[@"使用流量",[NSString stringWithFormat:@"%@/%@", [self spaceSize:info.data_counter unit:NO], [self spaceSize:info.plan_monthly_data]]],
                  @[@"流量比例", [NSString stringWithFormat:@"x%ld", info.monthly_data_multiplier]],
                  @[@"磁盘空间",[self spaceSize:info.plan_disk]],
                  @[@"物理内存",[self spaceSize:info.plan_ram]],
                  @[@"虚拟内存",[self spaceSize:info.plan_swap]],
                  @[@"系统",info.os],
                  @[@"邮件",info.email],
                  @[@"重置日期",[fmt stringFromDate:[NSDate dateWithTimeIntervalSince1970:info.data_next_reset]]],
                  @[@"IP地址",info.ip_addresses.firstObject],
                  @[@"挂起",info.suspended?@"是":@"否"]];
    [self.tableView reloadData];
}
      
- (NSString *)spaceSize:(long)size {
    return [self spaceSize:size unit:YES];
}

- (NSString *)spaceSize:(long)size unit:(BOOL)unit {
    if (size < 1024*1024) {
        return [NSString stringWithFormat:@"%.2f%@", size/1024.0, unit?@" KB":@""];
    } else if (size < 1024*1024*1024) {
        return [NSString stringWithFormat:@"%.2f%@", size/1024.0/1024, unit?@" MB":@""];
    } else {
        return [NSString stringWithFormat:@"%.2f%@", size/1024.0/1024/1024, unit?@" GB":@""];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NLVPSInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InfoCell" forIndexPath:indexPath];
    NSArray *items = self.data[indexPath.row];
    cell.titleLabel.text = items.firstObject;
    cell.contentLabel.text = items.lastObject;
    return cell;
}

@end
