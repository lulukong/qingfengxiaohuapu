//
//  AppDelegate.m
//  xiaohuapu
//
//  Created by lulu on 14-1-2.
//  Copyright (c) 2014年 dianjoy. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate
@synthesize navController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    ViewController *viewController = [[ViewController alloc] init];
    self.window.rootViewController = viewController;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent];
    self.navController = [[UINavigationController alloc] initWithRootViewController:viewController];
    float verson = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (verson >= 7.0) {
        [self.navController.navigationBar setBackgroundImage:[UIImage imageNamed:@"tab7.png"] forBarMetrics:UIBarMetricsDefault];
    }
    else 
    {
        [self.navController.navigationBar setBackgroundImage:[UIImage imageNamed:@"tab.png"] forBarMetrics:UIBarMetricsDefault];
    }
    //    [self.window addSubview:self.navController.view];
    self.window.rootViewController = self.navController;
    
    [self.window makeKeyAndVisible];
    // Override point for customization after application launch.
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskPortrait;
}

@end
