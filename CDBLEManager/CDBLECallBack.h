//
//  CDBLECallBack.h
//  CDBLEManager
//
//  Created by bbigcd on 16/11/2.
//  Copyright © 2016年 chendi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CDBLEDefine.h"

@interface CDBLECallBack : NSObject

#pragma mark - callback block
//设备状态改变的委托
@property (nonatomic, copy) CDCentralManagerDidUpdateStateBlock blockWithCentralManagerDidUpdateState;
//扫描到外围设备的委托
@property (nonatomic, copy) CDDiscoverPeripheralsBlock blockWithDiscoverPeripherals;

@end
