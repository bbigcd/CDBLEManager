//
//  CDCentralManager.h
//  CDBLEManager
//
//  Created by CDigcd on 16/10/31.
//  Copyright © 2016年 chendi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "CDBLEDefine.h"

@interface CDCentralManager : NSObject
<CBCentralManagerDelegate,
CBPeripheralDelegate>
{
    @public
    // 方法是否处理
    BOOL needScanForPeripherals;// 是否扫描Peripherals
    BOOL needConnectPeripheral;// 是否连接Peripherals
    BOOL needDiscoverServices;// 是否发现Services
    BOOL needDiscoverCharacteristics;// 是否获取Characteristics
    BOOL needReadValueForCharacteristic;// 是否获取（更新）Characteristics的值
    BOOL needDiscoverDescriptorsForCharacteristic;// 是否获取Characteristics的描述
    BOOL needReadValueForDescriptors;// 是否获取Descriptors的值
    BOOL oneReadValueForDescriptors;// 一次性处理
    int executeTime;// 方法执行时间
    NSTimer *connectTimer;
    NSMutableDictionary *pocket;// pocket
    CBCentralManager *centralManager;// 主设备
    
    @private
    NSMutableArray *connectedPeripherals;// 已经连接的设备
    NSMutableArray *discoverPeripherals;// 发现的设备数组
}


+ (instancetype)shareCDBluetooth;
// 扫描Peripherals
- (void)scanPeripherals;
// 连接Peripherals
- (void)connectPeripheral:(CBPeripheral *)peripheral;
// 断开设备连接
- (void)cancelPeripheralConnection:(CBPeripheral *)peripheral;
// 断开所有已连接的设备
- (void)cancelAllPeripheralsConnection;
// 停止扫描
- (void)cancelScan;



@end


@interface CDCallBack : NSObject

#pragma mark - callback block
//设备状态改变的委托
@property (nonatomic, copy) CDCentralManagerDidUpdateStateBlock blockOnCentralManagerDidUpdateState;
//发现peripherals
@property (nonatomic, copy) CDDiscoverPeripheralsBlock blockOnDiscoverPeripherals;
//连接callback
@property (nonatomic, copy) CDConnectedPeripheralBlock blockOnConnectedPeripheral;
//连接设备失败的block
@property (nonatomic, copy) CDFailToConnectBlock blockOnFailToConnect;
//断开设备连接的bock
@property (nonatomic, copy) CDDisconnectBlock blockOnDisconnect;
//发现services
@property (nonatomic, copy) CDDiscoverServicesBlock blockOnDiscoverServices;
//发现Characteristics
@property (nonatomic, copy) CDDiscoverCharacteristicsBlock blockOnDiscoverCharacteristics;
//发现更新Characteristics的
@property (nonatomic, copy) CDReadValueForCharacteristicBlock blockOnReadValueForCharacteristic;
//获取Characteristics的名称
@property (nonatomic, copy) CDDiscoverDescriptorsForCharacteristicBlock blockOnDiscoverDescriptorsForCharacteristic;
//获取Descriptors的值
@property (nonatomic, copy) CDReadValueForDescriptorsBlock blockOnReadValueForDescriptors;

@property (nonatomic, copy) CDDidWriteValueForCharacteristicBlock blockOnDidWriteValueForCharacteristic;

@property (nonatomic, copy) CDDidWriteValueForDescriptorBlock blockOnDidWriteValueForDescriptor;

@property (nonatomic, copy) CDDidUpdateNotificationStateForCharacteristicBlock blockOnDidUpdateNotificationStateForCharacteristic;

@property (nonatomic, copy) CDDidReadRSSIBlock blockOnDidReadRSSI;

@property (nonatomic, copy) CDDidDiscoverIncludedServicesForServiceBlock blockOnDidDiscoverIncludedServicesForService;

@property (nonatomic, copy) CDDidUpdateNameBlock blockOnDidUpdateName;

@property (nonatomic, copy) CDDidModifyServicesBlock blockOnDidModifyServices;


//babyBluettooth stopScan方法调用后的回调
@property(nonatomic, copy) CDCancelScanBlock blockOnCancelScan;
//babyBluettooth stopConnectAllPerihperals 方法调用后的回调
@property(nonatomic, copy) CDCancelAllPeripheralsConnectionBlock blockOnCancelAllPeripheralsConnection;
//babyBluettooth 蓝牙使用的参数参数
//@property(nonatomic, strong) BabyOptions *babyOptions;


#pragma mark - 过滤器Filter
/* 发现peripherals规则 */
@property (nonatomic, copy) BOOL (^filterOnDiscoverPeripherals)(NSString *peripheralName, NSDictionary *advertisementData, NSNumber *RSSI);
//连接peripherals规则
@property (nonatomic, copy) BOOL (^filterOnconnectToPeripherals)(NSString *peripheralName, NSDictionary *advertisementData, NSNumber *RSSI);



@end

