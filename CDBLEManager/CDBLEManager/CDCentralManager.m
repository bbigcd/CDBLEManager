//
//  CDCentralManager.m
//  CDBLEManager
//
//  Created by bbigcd on 16/10/31.
//  Copyright © 2016年 chendi. All rights reserved.
//

#import "CDCentralManager.h"

@implementation CDCentralManager

#pragma mark --CDCentralManager--

- (instancetype)init{
    if (self = [super init]) {
        centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
        //pocket广播包 其他一些属性初始化
        connectedPeripherals = [[NSMutableArray alloc]init];//连接的外围设备
        discoverPeripherals = [[NSMutableArray alloc]init];//发现的外围设备
    }
    return self;
}


// 扫描外围设备
- (void)scanPeripherals{
    // 调用系统中心管理者的Api，参数都为nil, 则扫描所有的外围设备
    [centralManager scanForPeripheralsWithServices:nil options:nil];
}

// 连接外围设备
- (void)connectPeripheral:(CBPeripheral *)peripheral{
    [centralManager connectPeripheral:peripheral options:nil];
}

// 断开外围设备连接
- (void)cancelPeripheralConnection:(CBPeripheral *)peripheral{
    [centralManager cancelPeripheralConnection:peripheral];
}

// 断开所有已连接的设备
- (void)cancelAllPeripheralsConnection{
    for (int i = 0; i < connectedPeripherals.count; i++) {
        [centralManager cancelPeripheralConnection:connectedPeripherals[i]];
    }
}

// 停止扫描
- (void)stopScan{
    [centralManager stopScan];
}

#pragma mark - 设备list管理
// 增加发现的设备
- (void)addDiscoverPeripheral:(CBPeripheral *)peripheral{
    if (![discoverPeripherals containsObject:peripheral]) {
        [discoverPeripherals addObject:peripheral];
    }
}
// 增加设备
- (void)addPeripheral:(CBPeripheral *)peripheral {
    if (![connectedPeripherals containsObject:peripheral]) {
        [connectedPeripherals addObject:peripheral];
    }
}
// 删除设备
- (void)deletePeripheral:(CBPeripheral *)peripheral{
    [connectedPeripherals removeObject:peripheral];
}
// 根据设备名称查找已连接的设备
- (CBPeripheral *)findConnectedPeripheral:(NSString *)peripheralName {
    for (CBPeripheral *p in connectedPeripherals) {
        if ([p.name isEqualToString:peripheralName]) {
            return p;
        }
    }
    return nil;
}
// 查找连接的设备
- (NSArray *)findConnectedPeripherals{
    return connectedPeripherals;
}



#pragma mark --CBCentralManagerDelegate--
- (void)centralManagerDidUpdateState:(CBCentralManager *)central{
    [cdbleCallBack blockWithCentralManagerDidUpdateState](central);
    if (central.state == CBCentralManagerStatePoweredOn) {
        [self scanPeripherals];
        NSLog(@"设备开始扫描");
    }
}

- (void)centralManager:(CBCentralManager *)central willRestoreState:(NSDictionary<NSString *, id> *)dict{
    
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *, id> *)advertisementData RSSI:(NSNumber *)RSSI{
    
    [cdbleCallBack blockWithDiscoverPeripherals](central, peripheral, advertisementData, RSSI);
    
    // 记录扫描到的所有外围设备
    [self addDiscoverPeripheral:peripheral];
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{
    [cdbleCallBack blockWithDidConnectPeripheralBlock](central, peripheral);
}

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error{
    
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error{
    
}

#pragma mark --CBPeripheralDelegate--

- (void)peripheralDidUpdateName:(CBPeripheral *)peripheral{
    
}

- (void)peripheral:(CBPeripheral *)peripheral didModifyServices:(NSArray<CBService *> *)invalidatedServices{
    
}

- (void)peripheralDidUpdateRSSI:(CBPeripheral *)peripheral error:(nullable NSError *)error{
    
}

- (void)peripheral:(CBPeripheral *)peripheral didReadRSSI:(NSNumber *)RSSI{
    
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(nullable NSError *)error{
    
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverIncludedServicesForService:(CBService *)service error:(nullable NSError *)error{
    
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(nullable NSError *)error{
    
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error{
    
}

- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error{
    
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error{
    
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error{
    
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForDescriptor:(CBDescriptor *)descriptor error:(nullable NSError *)error{
    
}

- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForDescriptor:(CBDescriptor *)descriptor error:(nullable NSError *)error{
    
}


@end











