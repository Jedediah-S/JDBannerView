//
//  JDBannerView.h
//  JDBannerView
//
//  Created by My Mac on 2019/3/12.
//  Copyright © 2019年 Jed. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JDBannerView : UIView

/// 初始化bannerView
+ (instancetype)initBannerViewWithFrame:(CGRect)frame;
- (void)setupImageUrls:(NSMutableArray *)urls;

@end

NS_ASSUME_NONNULL_END
