//
//  AppDelegate.m
//  HYNewFeatureViewDemo
//
//  Created by 徐天宇 on 16/4/15.
//  Copyright © 2016年 HY. All rights reserved.
//

#import "AppDelegate.h"
#import "HYNewFeatureView.h"
#import "ViewController.h"

#define ScreenBounds [UIScreen mainScreen].bounds
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    UIWindow *windwow = [[UIWindow alloc] initWithFrame:ScreenBounds];
    self.window = windwow;
    self.window.rootViewController = [[ViewController alloc] init];
    [self.window makeKeyAndVisible];
    
//    [self showNewFeatureMethod1];
    [self showNewFeatureMethod2];
    
    return YES;
}

- (void)showNewFeatureMethod1{
    
    //初始化一个新特性页面对象
    HYNewFeatureView *newFeatureSC = [[HYNewFeatureView alloc] initWithBaseImageName:@"feature"
                                                                            imageNum:3
                                                          pageControlNormalImageName:@"PageControlNormal"
                                                       pageControlimageHighlitedName:@"PageControlHighlited"
                                                                     pageControlRect:(CGRect){0,ScreenHeight-80,ScreenWidth,30}];
    newFeatureSC.imageTypeStr = @"jpg";//新特性界面的文件类型，默认是png
    newFeatureSC.lastViewColor = [UIColor clearColor];//默认白色，可进行设置
    newFeatureSC.pageControl.imgSize = 10;//默认13，可进行设置
    newFeatureSC.pageControl.spaceWidth = 5;//默认10，可进行设置
    //显示这个新特性页面
    [newFeatureSC show];
}

- (void)showNewFeatureMethod2{
    
    //使用默认基本名称feature，
    //默认page控制器名称PageControlNormal/PageControlHighlited
    //默认page控制器位置(CGRect){0,ScreenHeight-80,ScreenWidth,30}
    HYNewFeatureView *newFeatureSC = [[HYNewFeatureView alloc] initWithImageNum:3];
    newFeatureSC.imageTypeStr = @"jpg";
    
    //显示并对用户阅读完以及跳过操作做block回调处理
    [newFeatureSC showWithHidden:^(BOOL isClickSkip, BOOL isReadFinish) {
        
        NSLog(@"%i %i",isClickSkip, isReadFinish);
    }];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
