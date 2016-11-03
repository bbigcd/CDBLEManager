//
//  CDBLEManager.h
//  CDBLEManager
//
//  Created by bbigcd on 16/11/2.
//  Copyright © 2016年 chendi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface CDBLEManager : NSObject

#pragma mark --工具方法--
+ (instancetype)shareCDBLEManager;

- (void)stopScan;

- (void)connectPeripheral:(CBPeripheral *)peripheral;

#pragma mark --block--
- (void)cd_setBlockWithCentralManagerDidUpdateState:(void (^)(CBCentralManager *central))block;

- (void)cd_setBlockWithDiscoverToPeripherals:(void (^)(CBCentralManager *central, CBPeripheral *peripheral, NSDictionary*advertisementData, NSNumber *RSSI))block;

- (void)cd_setBlockWithDidConnectPeripheral:(void (^)(CBCentralManager *central,CBPeripheral *peripheral))block;

@end
