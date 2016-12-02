//
//  CDCentralManager.h
//  CDBLEManager
//
//  Created by CDigcd on 16/10/31.
//  Copyright © 2016年 chendi. All rights reserved.
//  BLE中心管理者
/*
 1.扫描
 2.连接



*/
#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "CDBLECallBack.h"


@interface CDCentralManager : NSObject
<CBCentralManagerDelegate,
CBPeripheralDelegate>
{
    @public
    // 方法是否处理
//    BOOL needScanForPeripherals;// 是否扫描Peripherals
//    BOOL needConnectPeripheral;// 是否连接Peripherals
//    BOOL needDiscoverServices;// 是否发现Services
//    BOOL needDiscoverCharacteristics;// 是否获取Characteristics
//    BOOL needReadValueForCharacteristic;// 是否获取（更新）Characteristics的值
//    BOOL needDiscoverDescriptorsForCharacteristic;// 是否获取Characteristics的描述
//    BOOL needReadValueForDescriptors;// 是否获取Descriptors的值
//    BOOL oneReadValueForDescriptors;// 一次性处理
//    int executeTime;// 方法执行时间
//    NSTimer *connectTimer;
//    NSMutableDictionary *pocket;// pocket
    CBCentralManager *centralManager;// 主设备
    CDBLECallBack *cdbleCallBack;
    
    @private
    NSMutableArray *connectedPeripherals;// 已经连接的设备
    NSMutableArray *discoverPeripherals;// 发现的设备数组
}


// 扫描Peripherals
- (void)scanPeripherals;
// 停止扫描
- (void)stopScan;

// 连接Peripherals
- (void)connectPeripheral:(CBPeripheral *)peripheral;
// 断开设备连接
- (void)cancelPeripheralConnection:(CBPeripheral *)peripheral;
// 断开所有已连接的设备
- (void)cancelAllPeripheralsConnection;


@end




