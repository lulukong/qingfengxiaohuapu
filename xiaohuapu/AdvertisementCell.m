//
//  AdvertisementCell.m
//  xiaohuapu
//
//  Created by lulu on 14-1-11.
//  Copyright (c) 2014年 dianjoy. All rights reserved.
//

#import "AdvertisementCell.h"

@implementation AdvertisementCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        [self addSubview:backgroundView];
//        adController = [DianJoyAdController sharedDianJoyAdController];
//        [adController setAdDelegate:self];
//        [adController setAppId:@"2652099a792fbc3d59f887113a3bb3d2"];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)didFinishLoadAd:(DianJoyAdController *)adController0
{
    UIView *view = [adController0 getAdView];
    [self addSubview:view];
}

@end
