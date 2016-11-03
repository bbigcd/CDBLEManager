//
//  CDBLEManager.m
//  CDBLEManager
//
//  Created by bbigcd on 16/11/2.
//  Copyright © 2016年 chendi. All rights reserved.
//

#import "CDBLEManager.h"
#import "CDBLECallBack.h"
#import "CDCentralManager.h"

@implementation CDBLEManager
{
    CDBLECallBack *cdbleCallBack;
    CDCentralManager *centralManager;
}

#pragma mark --工厂方法--

+ (instancetype)shareCDBLEManager{
    static CDBLEManager *share = nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        share = [[CDBLEManager alloc]init];
    });
    return share;
}

- (instancetype)init{
    if (self = [super init]) {
        centralManager = [[CDCentralManager alloc] init];
        cdbleCallBack = [[CDBLECallBack alloc] init];
        centralManager->cdbleCallBack = cdbleCallBack;
    }
    return self;
}

#pragma mark --block--

- (void)cd_setBlockWithCentralManagerDidUpdateState:(void (^)(CBCentralManager *central))block{
    [cdbleCallBack setBlockWithCentralManagerDidUpdateState:block];
}

- (void)cd_setBlockWithDiscoverToPeripherals:(void (^)(CBCentralManager *central, CBPeripheral *peripheral, NSDictionary*advertisementData, NSNumber *RSSI))block{
    [cdbleCallBack setBlockWithDiscoverPeripherals:block];
}

@end
