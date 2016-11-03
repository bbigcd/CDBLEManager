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
//扫描外围设备
typedef void (^CDDiscoverPeripheralsBlock)(CBCentralManager *central, CBPeripheral *peripheral, NSDictionary*advertisementData, NSNumber *RSSI);


@end
