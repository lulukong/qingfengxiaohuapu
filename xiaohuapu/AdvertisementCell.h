//
//  AdvertisementCell.h
//  xiaohuapu
//
//  Created by lulu on 14-1-11.
//  Copyright (c) 2014年 dianjoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DianJoyAdController.h"

@interface AdvertisementCell : UITableViewCell<DianJoyAdControllerDelegate>
{
    DianJoyAdController *adController;
}

@end
