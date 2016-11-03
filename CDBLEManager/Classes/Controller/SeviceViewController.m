//
//  SeviceViewController.m
//  CDBLEManager
//
//  Created by bbigcd on 16/11/3.
//  Copyright © 2016年 chendi. All rights reserved.
//

#import "SeviceViewController.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface SeviceViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *sevices;

@end

@implementation SeviceViewController

static NSString *const ID = @"cell";

- (UITableView *)tableView {
    if(_tableView == nil) {
        CGRect frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        [_tableView setTableFooterView:[[UIView alloc] init]];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

#pragma mark --UIViewController--

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sevices = [[NSMutableArray alloc] init];
    [self tableView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self loadData];
    });
    
    [self CDBLEDelegate];
}

- (void)CDBLEDelegate{
//    __weak typeof(self) weakSelf = self;
    [self.CDBLEManager cd_setBlockWithDidConnectPeripheral:^(CBCentralManager *central, CBPeripheral *peripheral){
        NSLog(@"%@", peripheral);
    }];
    
}

- (void)loadData{
    [self.CDBLEManager connectPeripheral:_currenPeripheral];
}

#pragma mark --UITableViewDataSource--

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = _currenPeripheral.name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end
