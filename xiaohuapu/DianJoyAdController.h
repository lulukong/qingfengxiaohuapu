//
//  DianJoyAdController.h
//  dianJoy_nativeAD_iOS_SDK
//
//  Created by Noodles Wang on 1/2/14.
//  Copyright (c) 2014 Noodles Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class  DianJoyAdController;

@protocol DianJoyAdControllerDelegate <NSObject>
/**
 *  广告列表加载完毕，可以通过adController的实例方法
 *
 *  @param adController DianJoyAdController实例getAdView获取广告
 */
- (void)didFinishLoadAd:(DianJoyAdController *)adController;
/**
 *  获取广告失败
 *
 *  @param error 失败描述
 */
- (void)failToReceiveAdWithError:(NSError *)error;
@end

@interface DianJoyAdController : NSObject

/**
 *  单例方法，返回DianJoyAdController实例
 *
 *  @return DianJoyAdController实例
 */
+ (id)sharedDianJoyAdController;

/**
 *  DianJoyAdController回调方法
 *
 *  @param delegate 实现DianJoyAdControllerDelegate的实例
 */
- (void)setAdDelegate:(id)delegate;

/**
 *  获取一条广告
 *
 *  @return 广告View对象，size：320X214 position：(0,0)
 */
- (UIView*)getAdView;

/**
 *  设置您的appId，DianJoy开发者后台，注册iOS应用获得唯一的id
 *
 *  @param appId appId
 */
- (void)setAppId:(NSString *)appId;


@end
