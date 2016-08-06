# HYNewFeatureViewDemo
HYNewFeatureViewDemo  
首次启动引导页/新特性显示页     
  
![image](https://github.com/xtyHY/HYNewFeatureView/blob/master/demo.gif)  

## 说明  
初始化一个全屏的新特性界面，根据基本名称和图片数量创建  
图片放在工程目录中，使用 `基本名称_机型_数量.格式` 来命名  
  
数量:从0开始
机型:iPhone4/4s对应4，iPhone5/5s对应5，iPhone6/6s对应6，iPhone6p/6sp对应6p    
举例:3张名字为feature的新特性png图需要以下文件  
feature_4_0.png feature_5_0.png feature_6_0.png feature_6p_0.png  
feature_4_1.png feature_5_1.png feature_6_1.png feature_6p_1.png  
feature_4_2.png feature_5_2.png feature_6_2.png feature_6p_2.png  
  
具体可见Demo工程

## 使用方法
  
### 初始化一个新特性页面对象

1. 方式一
	
	```objc
	HYNewFeatureView *newFeatureSC = [[HYNewFeatureView alloc]  
					   initWithBaseImageName:@"图片基本名称"  
									imageNum:图片数量  
				  pageControlNormalImageName:@"页面指示器图片Normal名称"  
			   pageControlimageHighlitedName:@"页面指示器图片HighLight名称"  
					    	 pageControlRect:页面指示器尺寸];  
	```
	
2. 方式二
	
	```objc
	/*使用默认方案初始化
 	 *图片基本名称feature
 	 *page指示器名称PageControlNormal/PageControlHighlited
 	 *page指示器距离底部80，单个Size为30x30
 	 */
	HYNewFeatureView *newFeatureSC = [[HYNewFeatureView alloc] initWithImageNum:图片数量];
	```
  
###  显示新特性界面  

1. 方式一
	简单的显示
	
	```objc
	[newFeatureSC show];
	```

2. 方式二
	支持显示后隐藏的block回调
	
	```objc
	[newFeatureSC showWithHidden:^(BOOL isClickSkip, BOOL isReadFinish) {
        NSLog(@"%i %i",isClickSkip, isReadFinish);
   }];
	```
  
## 可配置的属性
```    
//新特性界面的文件类型，默认是png
newFeatureSC.imageTypeStr = @"jpg";  
	  
//除启动图外额外的一个用于效果显示界面的背景颜色， 默认白色
newFeatureSC.lastViewColor = [UIColor clearColor];  
	  
//页面指示器的大小,默认13
newFeatureSC.pageControl.imgSize = 10;  
 
//页面指示器的间隔，默认10
newFeatureSC.pageControl.spaceWidth = 5;  
```


