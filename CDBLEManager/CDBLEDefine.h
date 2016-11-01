//
//  CDBLEDefine.h
//  CDBLEManager
//
//  Created by bbigcd on 16/10/31.
//  Copyright © 2016年 chendi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface CDBLEDefine : NSObject

//设备状态改变的委托
typedef void (^CDCentralManagerDidUpdateStateBlock)(CBCentralManager *central);
//找到设备的委托
typedef void (^CDDiscoverPeripheralsBlock)(CBCentralManager *central,CBPeripheral *peripheral,NSDictionary *advertisementData, NSNumber *RSSI);
//连接设备成功的block
typedef void (^CDConnectedPeripheralBlock)(CBCentralManager *central,CBPeripheral *peripheral);
//连接设备失败的block
typedef void (^CDFailToConnectBlock)(CBCentralManager *central,CBPeripheral *peripheral,NSError *error);
//断开设备连接的bock
typedef void (^CDDisconnectBlock)(CBCentralManager *central,CBPeripheral *peripheral,NSError *error);
//找到服务的block
typedef void (^CDDiscoverServicesBlock)(CBPeripheral *peripheral,NSError *error);
//找到Characteristics的block
typedef void (^CDDiscoverCharacteristicsBlock)(CBPeripheral *peripheral,CBService *service,NSError *error);
//更新（获取）Characteristics的value的block
typedef void (^CDReadValueForCharacteristicBlock)(CBPeripheral *peripheral,CBCharacteristic *characteristic,NSError *error);
//获取Characteristics的名称
typedef void (^CDDiscoverDescriptorsForCharacteristicBlock)(CBPeripheral *peripheral,CBCharacteristic *service,NSError *error);
//获取Descriptors的值
typedef void (^CDReadValueForDescriptorsBlock)(CBPeripheral *peripheral,CBDescriptor *descriptor,NSError *error);

//babyBluettooth cancelScanBlock方法调用后的回调
typedef void (^CDCancelScanBlock)(CBCentralManager *centralManager);
//babyBluettooth cancelAllPeripheralsConnection 方法调用后的回调
typedef void (^CDCancelAllPeripheralsConnectionBlock)(CBCentralManager *centralManager);


typedef void (^CDDidWriteValueForCharacteristicBlock)(CBCharacteristic *characteristic,NSError *error);

typedef void (^CDDidWriteValueForDescriptorBlock)(CBDescriptor *descriptor,NSError *error);

typedef void (^CDDidUpdateNotificationStateForCharacteristicBlock)(CBCharacteristic *characteristic,NSError *error);

typedef void (^CDDidReadRSSIBlock)(NSNumber *RSSI,NSError *error);

typedef void (^CDDidDiscoverIncludedServicesForServiceBlock)(CBService *service,NSError *error);

typedef void (^CDDidUpdateNameBlock)(CBPeripheral *peripheral);

typedef void (^CDDidModifyServicesBlock)(CBPeripheral *peripheral,NSArray *invalidatedServices);



@end
