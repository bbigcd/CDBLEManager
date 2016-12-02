//
//  CDBLEManager.h
//  CDBLEManager
//
//  Created by bbigcd on 16/11/2.
//  Copyright © 2016年 chendi. All rights reserved.
//  对外交互数据

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface CDBLEManager : NSObject

#pragma mark --工具方法--
+ (instancetype)shareCDBLEManager;

- (void)stopScan;

- (void)cancelAllPeripheralsConnection;

- (void)connectPeripheral:(CBPeripheral *)peripheral;

#pragma mark --block-- 扫描连接阶段
- (void)cd_setBlockWithCentralManagerDidUpdateState:(void (^)(CBCentralManager *central))block;

- (void)cd_setBlockWithDiscoverToPeripherals:(void (^)(CBCentralManager *central,
                                                       CBPeripheral *peripheral,
                                                       NSDictionary*advertisementData,
                                                       NSNumber *RSSI))block;

- (void)cd_setBlockWithDidConnectPeripheral:(void (^)(CBCentralManager *central,
                                                      CBPeripheral *peripheral))block;


- (void)cd_setBlockWithDidFailConnectPeripheral:(void (^)(CBCentralManager *central,
                                                          CBPeripheral *peripheral,
                                                          NSError *error))block;

#pragma mark --block-- 已连接数据交互阶段

- (void)cd_setBlockWithDiscoverServices:(void (^)(CBPeripheral *peripheral,
                                                  NSError *error))block;




@end
