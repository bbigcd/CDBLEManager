//
//  SeviceViewController.h
//  CDBLEManager
//
//  Created by bbigcd on 16/11/3.
//  Copyright © 2016年 chendi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "CDBLEManager.h"

@interface SeviceViewController : UIViewController

@property (nonatomic, strong) CBPeripheral *currenPeripheral;
@property (nonatomic, strong) CDBLEManager *CDBLEManager;

@end

