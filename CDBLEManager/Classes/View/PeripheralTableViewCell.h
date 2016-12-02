//
//  PeripheralTableViewCell.h
//  CDBLEManager
//
//  Created by bbigcd on 2016/12/2.
//  Copyright © 2016年 chendi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PeripheralTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *macLabel;

@property (weak, nonatomic) IBOutlet UILabel *rssiLabel;

@end
