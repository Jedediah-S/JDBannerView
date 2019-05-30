//
//  JDBannerView.m
//  JDBannerView
//
//  Created by My Mac on 2019/3/12.
//  Copyright © 2019年 Jed. All rights reserved.
//

#import "JDBannerView.h"
#import "JDImageView.h"
#import "UIImageView+WebCache.h"

//#define viewWidth self.bounds.size.width
//#define viewHeight self.bounds.size.height

@interface JDBannerView ()<UIScrollViewDelegate>{
    CGFloat viewWidth;
    CGFloat viewHeight;
}

@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,strong) NSMutableArray *imageUrls;
@property (nonatomic,assign) NSInteger currentPage;
@property (nonatomic,weak) JDImageView *leftImageView;
@property (nonatomic,weak) JDImageView *midImageView;
@property (nonatomic,weak) JDImageView *rightImageView;

@end

@implementation JDBannerView

#pragma mark - init
+ (instancetype)initBannerViewWithFrame:(CGRect)frame{
    
    JDBannerView *bannerView = [[JDBannerView alloc] initWithFrame:frame];
    return bannerView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        viewWidth  = self.bounds.size.width;
        viewHeight = self.bounds.size.height;
        [self setupUI];
    }
    return self;
}

#pragma mark - UIScrollViewDelegate
// 用户开始拖拽
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [self stopTimer];
}
// 用户拖拽中
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [self movePageControlWithOffestX:scrollView.contentOffset.x];
}
// 用户拖拽后动画结束调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
  
    NSInteger index = scrollView.contentOffset.x/scrollView.frame.size.width;
    if(index == 0){
        // 向左滑动
        self.currentPage --;
        if(self.currentPage < 0){
            self.currentPage = self.imageUrls.count-1;
        }
    }else if (index == 2){
        // 向右滑动
        self.currentPage ++;
        if(self.currentPage == self.imageUrls.count){
            self.currentPage = 0;
        }
    }
    
    [self changeImageViewImage];
    
    [self startTimer];
}
// setContentOffset:animated等函数动画结束调用
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    self.currentPage ++;
    if(self.currentPage == self.imageUrls.count){
        self.currentPage = 0;
    }
    [self changeImageViewImage];
}
// 改变imageView.image
- (void)changeImageViewImage{
    
    [self.midImageView sd_setImageWithURL:self.imageUrls[self.currentPage]];
    self.scrollView.contentOffset = CGPointMake(viewWidth, 0);
    [self.rightImageView sd_setImageWithURL:[self nextImageUrl]];
    [self.leftImageView sd_setImageWithURL:[self previousImageUrl]];
    self.pageControl.currentPage = self.currentPage;
}

#pragma mark - pageControl
// 上一个图片地址
- (NSURL *)previousImageUrl{
    
    if(self.currentPage == 0){
        return [self.imageUrls lastObject];
    }else{
        return self.imageUrls[self.currentPage - 1];
    }
    
}
// 下一个图片地址
- (NSURL *)nextImageUrl{
    
    if(self.currentPage == self.imageUrls.count - 1){
        return [self.imageUrls firstObject];
    }else{
        return self.imageUrls[self.currentPage + 1];
    }
}
// 用户拖拽过程中改变pageControl.currentPage
- (void)movePageControlWithOffestX:(CGFloat)offestX{
    
    NSInteger movePage = self.currentPage;
    if(offestX < viewWidth/2){
        movePage -= 1;
    }else if (offestX > viewWidth/2*3){
        movePage += 1;
    }else{
        movePage = self.currentPage;
    }
    if(movePage == -1) movePage = self.imageUrls.count-1;
    if(movePage == self.imageUrls.count) movePage = 0;
    self.pageControl.currentPage = movePage;
}

#pragma mark - timerControl
// 开始定时
- (void)startTimer{
    
    if(self.timer == nil){
        self.timer = [NSTimer timerWithTimeInterval:5.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
    
}
// 结束定时
- (void)stopTimer{
    
    if(self.timer != nil){
        [self.timer invalidate];
        self.timer = nil;
    }
}
// 定时切换到下一页
- (void)nextPage{
    
    [self.scrollView setContentOffset:CGPointMake(viewWidth*2, 0) animated:YES];
}

#pragma mark - setter
- (void)setupImageUrls:(NSMutableArray *)urls{
    
    if(urls.count == 0) return;
    
    self.currentPage = 0;
    self.imageUrls = urls;
    self.pageControl.numberOfPages = urls.count;
    
    if(urls.count >= 3){
        [self.midImageView sd_setImageWithURL:urls[0]];
        [self.rightImageView sd_setImageWithURL:[self nextImageUrl]];
        [self.leftImageView sd_setImageWithURL:[self previousImageUrl]];
    }
    
    [self startTimer];
}

#pragma mark - setupUI
- (void)setupUI{
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.scrollView.contentSize = CGSizeMake(viewWidth*3, viewHeight);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    self.scrollView.delegate = self;
    [self addSubview:self.scrollView];
    self.scrollView.contentOffset = CGPointMake(viewWidth, 0);
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(viewWidth/2-25, viewHeight-20, 50, 10)];
    self.pageControl.numberOfPages = 3;
    self.pageControl.pageIndicatorTintColor = [UIColor grayColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor blueColor];
    [self addSubview:self.pageControl];
    
    self.leftImageView = [self createJDImageViewWithFrame:CGRectMake(0, 0, viewWidth, viewHeight)];
    
    self.midImageView = [self createJDImageViewWithFrame:CGRectMake(viewWidth, 0, viewWidth, viewHeight)];
    
    self.rightImageView = [self createJDImageViewWithFrame:CGRectMake(viewWidth*2, 0, viewWidth, viewHeight)];
}

- (JDImageView *)createJDImageViewWithFrame:(CGRect)frame{
    
    JDImageView *imageView = [[JDImageView alloc] initWithFrame:frame];
    [self.scrollView addSubview:imageView];
    return imageView;
}

@end
