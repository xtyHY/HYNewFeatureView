//
//  HYNewFeatureView.m
//
//  Created by HY on 16/4/14.
//  Copyright © 2016年 HY. All rights reserved.
//

#import "HYNewFeatureView.h"

#define ScreenBounds [UIScreen mainScreen].bounds
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define SCREEN_MAX_LENGTH (MAX(ScreenWidth, ScreenHeight))
#define SCREEN_MIN_LENGTH (MIN(ScreenWidth, ScreenHeight))

#define IS_IPHONE_4 (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && [UIScreen mainScreen].scale == 3.0)

@implementation HYNewFeaturePageControl

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = NO;
    }
    return self;
}

- (void)setCurrentPage:(NSInteger)currentPage{
    
    [super setCurrentPage:currentPage];
    
    [self setNeedsDisplay];
}

- (void)setNumberOfPages:(NSInteger)numberOfPages{
    
    [super setNumberOfPages:numberOfPages];
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)iRect{
    
    if (_imageNormalName==nil || _imageHighlitedName==nil) {
        
        [super drawRect:iRect];
        
    }else{
        
        int i;
        CGRect rect;
        UIImage *image;
        
        iRect = self.bounds;
        
        self.pageIndicatorTintColor = [UIColor clearColor];
        self.currentPageIndicatorTintColor = [UIColor clearColor];
        
        if (self.opaque) {
            [self.backgroundColor set];
            UIRectFill(iRect);
        }
        
        UIImage *_activeImage = [UIImage imageNamed:_imageHighlitedName];
        UIImage *_inactiveImage = [UIImage imageNamed:_imageNormalName];
        CGFloat _kSpacing = _spaceWidth>0 ? _spaceWidth : 10;
        
        if (self.hidesForSinglePage && self.numberOfPages == 1) {
            return;
        }
        
        _imgSize = _imgSize>0? _imgSize : 13;
        
        rect.size.height = _imgSize;
        rect.size.width = self.numberOfPages * _imgSize + (self.numberOfPages - 1) * _kSpacing;
        rect.origin.x = floorf((iRect.size.width - rect.size.width) / 2.0);
        rect.origin.y = floorf((iRect.size.height - rect.size.height) / 2.0);
        rect.size.width = _imgSize;
        
        for (i = 0; i < self.numberOfPages; ++i) {
            image = (i == self.currentPage) ? _activeImage : _inactiveImage;
            [image drawInRect:rect];
            rect.origin.x += _imgSize + _kSpacing;
        }
    }
    
}

@end

@interface HYNewFeatureView()<UIScrollViewDelegate>{
    
    NSMutableArray *_imagePathArray;
    NSInteger _imageNum;
    NSString *_baseImageName;
    UIImageView *_imageViewBlank;
    UIScrollView *_scrollView;
}

@end

@implementation HYNewFeatureView

- (instancetype)initWithBaseImageName:(NSString *)baseName
                             imageNum:(NSInteger)imageNum
           pageControlNormalImageName:(NSString *)imageNormalName
        pageControlimageHighlitedName:(NSString *)imageHighlitedName
                      pageControlRect:(CGRect)pageControlRect
{
    
    self = [super init];
    if (self) {
        
        self.frame = ScreenBounds;
        _baseImageName = baseName;
        _imageNum = imageNum;
        _imagePathArray = [[NSMutableArray alloc] init];
        _scrollView = [[UIScrollView alloc] initWithFrame:ScreenBounds];
        
        _pageControl = [[HYNewFeaturePageControl alloc] initWithFrame:pageControlRect];
        _pageControl.imageNormalName = imageNormalName;
        _pageControl.imageHighlitedName = imageHighlitedName;
        _showPageControl = YES;
        
        [self initDefaultConfigUI];
    }
    return self;
}

#pragma mark 初始化配置
- (void)initDefaultConfigUI{
    
    _scrollView.userInteractionEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.bouncesZoom = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    
    _lastViewColor = _lastViewColor ? _lastViewColor : [UIColor whiteColor];
    _imageTypeStr = _imageTypeStr ? _imageTypeStr : @"png";
}

#pragma mark 根据图基本名称和数量配置对应的图片名称（show的时候调用）
- (void)configImageData{
    
    NSString *imageTypeStr = _imageTypeStr;
    NSString *imageSizeStr = [self getImageNameSuffixByIPhoneSize];
    
    for (NSInteger i=0; i<_imageNum; i++) {
        
        //如果baseImageName是feature imageNum是2 的话 在iphone4、4s上是feature1_4
        NSMutableString *imageNameStr = [[NSMutableString alloc] initWithFormat:@"%@%li_%@",_baseImageName,i,imageSizeStr];
        
#warning 请注意传入的名字和文件名字是否一致，否则必崩
        NSString *imagePath = [[NSBundle mainBundle] pathForResource:imageNameStr ofType:imageTypeStr];
        
        [_imagePathArray addObject:imagePath];
    }
}

#pragma mark 放置图片（show的时候调用）
- (void)setUpSubviews{
    
    for (NSInteger i=0; i<_imagePathArray.count+1; i++) {
        
        if (i<_imagePathArray.count) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:(CGRect){i*ScreenWidth, 0, ScreenWidth, ScreenHeight}];
            imageView.image = [UIImage imageWithContentsOfFile:_imagePathArray[i]];
            imageView.backgroundColor = [UIColor whiteColor];
            [_scrollView addSubview:imageView];
        }else{
            _imageViewBlank = [[UIImageView alloc] initWithFrame:(CGRect){i*ScreenWidth, 0, ScreenWidth, ScreenHeight}];
            _imageViewBlank.backgroundColor = _lastViewColor;
            [_scrollView addSubview:_imageViewBlank];
        }
    }
    
    _scrollView.contentSize = (CGSize){ScreenWidth*(_imagePathArray.count+1),ScreenHeight};
    [self addSubview:_scrollView];
    
    if (_showPageControl) {
        [_pageControl setNumberOfPages:_imagePathArray.count];
        [_pageControl setCurrentPage:0];
        [self addSubview:_pageControl];
    }
}

#pragma mark scroll滚动时若是最后一张则alpha渐变 移动完则移除所有
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if(scrollView.contentOffset.x-ScreenWidth*(_imageNum-1)>0){
        
        _imageViewBlank.alpha = 1.0-(scrollView.contentOffset.x-ScreenWidth*(_imageNum-1))/ScreenWidth;
        _pageControl.alpha = _imageViewBlank.alpha - 0.5;
    }else{
        _pageControl.currentPage = (NSInteger)(scrollView.contentOffset.x/ScreenWidth);
        _pageControl.alpha = 1;
        _imageViewBlank.alpha = 1;
    }
    
    //移动到最后直接移除所有
    if (scrollView.contentOffset.x == ScreenWidth*(_imageNum))
        [self hide];
}

#pragma mark 显示
- (void)showOnView:(UIView *)view{
    
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self configImageData];
    [self setUpSubviews];
    [view addSubview:self];
}

#pragma mark 移除所有
- (void)hide{
    
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self removeFromSuperview];
}

#pragma mark 根据机型获取名称后缀
- (NSString *)getImageNameSuffixByIPhoneSize{
    
    if (IS_IPHONE_4) {
        
        return @"4";
    }else if(IS_IPHONE_5){
        
        return @"5";
    }else if(IS_IPHONE_6){
        
        return @"6";
    }else if (IS_IPHONE_6P){
        
        return @"6p";
    }
    
    return @"";
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
