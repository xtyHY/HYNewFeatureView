//
//  ViewController.m
//  HYNewFeatureViewDemo
//
//  Created by HY on 16/4/15.
//  Copyright © 2016年 HY. All rights reserved.
//

#import "ViewController.h"
#import "HYNewFeatureView.h"

#define ScreenBounds [UIScreen mainScreen].bounds
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
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
    [newFeatureSC showOnView:self.view];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
