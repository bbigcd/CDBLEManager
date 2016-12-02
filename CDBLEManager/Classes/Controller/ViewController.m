//
//  ViewController.m
//  CDBLEManager
//
//  Created by bbigcd on 16/10/31.
//  Copyright © 2016年 chendi. All rights reserved.
//

#import "ViewController.h"
#import "CDBLEManager.h"
#import "SeviceViewController.h"
#import "PeripheralTableViewCell.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *peripherals;
@property (nonatomic, strong) NSMutableArray *peripheralsAD;
@property (nonatomic, strong) NSMutableArray *peripheralsRSSI;

@property (nonatomic, strong) CDBLEManager *CDBLEManager;
@property (nonatomic, assign) BOOL BLEConnecting;

@end

@implementation ViewController

static NSString *const ID = @"Cell";

- (UITableView *)tableView {
    if(_tableView == nil) {
        CGRect frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        [_tableView setRowHeight:80];
        [_tableView setTableFooterView:[[UIView alloc] init]];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

#pragma mark --UIViewController--

- (void)viewDidLoad {
    [super viewDidLoad];
    self.BLEConnecting = NO;
    self.peripherals = [[NSMutableArray alloc] init];
    self.peripheralsAD = [[NSMutableArray alloc] init];
    self.peripheralsRSSI = [[NSMutableArray alloc] init];
    
    self.CDBLEManager = [CDBLEManager shareCDBLEManager];

    [self CDBLEDelegate];
    
    [self tableView];
    [_tableView registerNib:[UINib nibWithNibName:@"PeripheralTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:ID];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"断开连接" style:UIBarButtonItemStylePlain target:self action:@selector(disconnectAllPeripheral)];
    self.navigationItem.rightBarButtonItem.enabled = _BLEConnecting;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.rightBarButtonItem.enabled = _BLEConnecting;
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
        if ([RSSI integerValue] < -60 || [RSSI integerValue] > 0) {
            return;
        }
        [weakSelf insertTableView:peripheral advertisementData:advertisementData RSSI:RSSI];
    }];
}

- (void)disconnectAllPeripheral{
    [self.CDBLEManager cancelAllPeripheralsConnection];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    NSLog(@"断开连接");
}

//插入table数据
-(void)insertTableView:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI{
    if(![self.peripherals containsObject:peripheral]) {//非包含的外围设备，加入到扫描到的外围设备数组里
        NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.peripherals.count inSection:0];
        [indexPaths addObject:indexPath];
        [self.peripherals addObject:peripheral];
        [self.peripheralsAD addObject:advertisementData];
        [self.peripheralsRSSI addObject:RSSI];
        [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

#pragma mark --UITableViewDataSource--

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.peripherals.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PeripheralTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[PeripheralTableViewCell alloc] init];
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    CBPeripheral *peripheral = [self.peripherals objectAtIndex:indexPath.row];
    NSDictionary *advertisement = [self.peripheralsAD objectAtIndex:indexPath.row];
    NSNumber *RSSI = [self.peripheralsRSSI objectAtIndex:indexPath.row];
    
    NSString *localName;
    if ([advertisement objectForKey:@"kCBAdvDataLocalName"]){
        localName = [NSString stringWithFormat:@"%ld - %@", indexPath.row + 1,[advertisement objectForKey:@"kCBAdvDataLocalName"]];
    }else{
        localName = peripheral.name;
    }
    
    cell.titleLabel.text = localName;
    //信号和服务
    cell.macLabel.text = @"MAC:读取中...";
    //找到cell并修改detaisText
    NSString *mac = [advertisement objectForKey:@"kCBAdvDataManufacturerData"];
    if (mac.length == 8) {
        cell.macLabel.text = [NSString stringWithFormat:@"MAC:%@", mac];
    }else{
        cell.macLabel.text = [NSString stringWithFormat:@"MAC:广播包中无mac"];
    }
    
    cell.rssiLabel.text = [NSString stringWithFormat:@"RSSI:%@", RSSI];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.CDBLEManager stopScan];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SeviceViewController *vc = [[SeviceViewController alloc] init];
    // 连接状态block
    [vc setBLEConnectingBlock:^(BOOL connecting) {
        _BLEConnecting = connecting;
    }];
    vc.currenPeripheral = self.peripherals[indexPath.row];
    vc.CDBLEManager = self.CDBLEManager;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
