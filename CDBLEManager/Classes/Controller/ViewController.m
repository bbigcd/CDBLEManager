//
//  ViewController.m
//  CDBLEManager
//
//  Created by bbigcd on 16/10/31.
//  Copyright © 2016年 chendi. All rights reserved.
//

#import "ViewController.h"
#import "CDBLEManager.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *peripherals;
@property (nonatomic, strong) NSMutableArray *peripheralsAD;
@property (nonatomic, strong) CDBLEManager *CDBLEManager;

@end

@implementation ViewController

static NSString *const ID = @"cell";

- (UITableView *)tableView {
    if(_tableView == nil) {
        CGRect frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
//        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
        [_tableView setTableFooterView:[[UIView alloc] init]];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

#pragma mark --UIViewController--

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.peripherals = [[NSMutableArray alloc]init];
    self.peripheralsAD = [[NSMutableArray alloc]init];
    
    self.CDBLEManager = [CDBLEManager shareCDBLEManager];

    [self CDBLEDelegate];
    
    [self tableView];
}


- (void)CDBLEDelegate{
    // 中心管理者设备的蓝牙状态
    __weak typeof(self) weakSelf = self;
    [self.CDBLEManager cd_setBlockWithCentralManagerDidUpdateState:^(CBCentralManager *central) {
        if(central.state == CBCentralManagerStatePoweredOn)
        {
            NSLog(@"蓝牙已经打开");
        }
    }];
    
    // 中心管理者扫描外围设备
    [self.CDBLEManager cd_setBlockWithDiscoverToPeripherals:^(CBCentralManager *central, CBPeripheral *peripheral, NSDictionary *advertisementData, NSNumber *RSSI) {
        [weakSelf insertTableView:peripheral advertisementData:advertisementData];
    }];
}

//插入table数据
-(void)insertTableView:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData{
    if(![self.peripherals containsObject:peripheral]) {//非包含的外围设备，加入到扫描到的外围设备数组里
        NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.peripherals.count inSection:0];
        [indexPaths addObject:indexPath];
        [self.peripherals addObject:peripheral];
        [self.peripheralsAD addObject:advertisementData];
        [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

#pragma mark --UITableViewDataSource--

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.peripherals.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    CBPeripheral *peripheral = [self.peripherals objectAtIndex:indexPath.row];
    NSDictionary *advertisement = [self.peripheralsAD objectAtIndex:indexPath.row];
    
    NSString *localName;
    if ([advertisement objectForKey:@"kCBAdvDataLocalName"]){
        localName = [NSString stringWithFormat:@"%ld -- %@", indexPath.row + 1,[advertisement objectForKey:@"kCBAdvDataLocalName"]];
    }else{
        localName = peripheral.name;
    }
    
    cell.textLabel.text = localName;
    //信号和服务
    cell.detailTextLabel.text = @"读取中...";
    //找到cell并修改detaisText
    NSString *mac = [advertisement objectForKey:@"kCBAdvDataManufacturerData"];
    if (mac.length == 8) {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", mac];
    }else{
        cell.detailTextLabel.text = [NSString stringWithFormat:@"广播包中无mac"];
    }
    
    
    return cell;
}




@end
