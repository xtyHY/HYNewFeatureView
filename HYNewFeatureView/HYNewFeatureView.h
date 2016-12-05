//
//  HYNewFeatureView.h
//
//  Created by HY on 16/4/14.
//  Copyright © 2016年 HY. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^NewFeatureViewHiddenBlock)(BOOL isClickSkip, BOOL isReadFinish);

/**
 *  @author HY, 16-04-15
 *
 *  @brief 显示性特性ScrollView上面的page指示器，重写用于控制指示器的大小、间距、传入指示图片，默认为宽高相同
 */
@interface HYNewFeaturePageControl : UIPageControl

@property (nonatomic, copy) NSString *imageNormalName;      //!<page指示器的Normal状态，传带后缀的或者直接拖到图片管理中
@property (nonatomic, copy) NSString *imageHighlitedName;   //!<page指示器的Highlited状态，传带后缀的或者直接拖到图片管理中
@property (nonatomic, assign) NSInteger spaceWidth; //!<两个指示器之间的间距，默认10
@property (nonatomic, assign) NSInteger imgSize;    //!<指示器图片的大小，默认13

@end

/**
 *  @author HY, 16-04-15
 *
 *  @brief 显示新特性的scrollview，默认显示pageControl，最后一个页面为白色（会随着滚动变透明），最终被移除一个全屏的新特性界面
 *         根据基本名称和图片数量创建
 *         图片放在工程目录中，使用 基本名称_机型_数量.格式 来命名
 *         机型识别为4和4s对应4，5和5s对应5，6和6s对应6，6p和6sp对应6p
 *         举例：3张名字为feature的新特性png图需要以下文件
 *              feature_4_0.png feature_5_0.png feature_6_0.png feature_6p_0.png
 *              feature_4_1.png feature_5_1.png feature_6_1.png feature_6p_1.png
 *              feature_4_2.png feature_5_2.png feature_6_2.png feature_6p_2.png
 */
@interface HYNewFeatureView : UIView

@property (nonatomic, copy) NSString *imageTypeStr; //!<图片文件的文件后缀，默认png
@property (nonatomic, assign) BOOL showPageControl; //!<是否显示page指示器，默认YES
@property (nonatomic, strong, readonly) HYNewFeaturePageControl *pageControl;//!<重写的page指示器对象，只读，可以通过这个对象进一步配置
@property (nonatomic, strong) UIColor *lastViewColor;//!<滚动到最后一个页面的颜色，默认白色（会随着滚动变透明）

/**
 *  @brief 使用默认方案初始化
 *         图片基本名称feature
 *         page指示器名称PageControlNormal/PageControlHighlited
 *         page指示器距离底部80，单个Size为30x30
 *  @param imageNum 图片数量
 */
- (instancetype)initWithImageNum:(NSInteger)imageNum;

/**
 *  @brief 初始化一个全屏的新特性界面，根据基本名称、图片数量、page指示器图片名称，page指示器距离创建
 */
- (instancetype)initWithBaseImageName:(NSString *)baseName
                             imageNum:(NSInteger)imageNum
           pageControlNormalImageName:(NSString *)imageNormalName
        pageControlimageHighlitedName:(NSString *)imageHighlitedName
                      pageControlRect:(CGRect)pageControlRect;

/**
 *  @brief 显示新特性界面
 */
- (void)show;

/**
 *  @brief 显示新特性界面
 *
 *  @param block 新特性界面隐藏回调
 */
- (void)showWithHidden:(NewFeatureViewHiddenBlock)block;

/**
 判断是否需要显示
 */
+ (BOOL)judgeNeedShow;

@end
