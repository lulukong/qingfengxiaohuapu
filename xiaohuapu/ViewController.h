//
//  ViewController.h
//  xiaohuapu
//
//  Created by lulu on 14-1-2.
//  Copyright (c) 2014年 dianjoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "DianJoyAdController.h"

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,DianJoyAdControllerDelegate>{
    NSMutableArray *dataArray;
    NSInteger page;
    NSInteger order;
    UITableView *mytableView;
    UIImageView *headimage;
    NSString *minTime;
    NSString *maxTime;
    int temp;
    DianJoyAdController *_adController;
    BOOL _adFinishLoad;
}

@property (retain, nonatomic) NSMutableArray *dataArray;
@property (retain, nonatomic) UITableView *mytableView;


@end
