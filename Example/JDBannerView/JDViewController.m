//
//  JDViewController.m
//  JDBannerView
//
//  Created by 13432414304@163.com on 05/30/2019.
//  Copyright (c) 2019 13432414304@163.com. All rights reserved.
//

#import "JDViewController.h"
#import "JDBannerView.h"

@interface JDViewController ()

@end

@implementation JDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    CGSize size = self.view.bounds.size;
    
    JDBannerView *bannerView = [JDBannerView initBannerViewWithFrame:CGRectMake(0, 88, size.width, 200)];
    [bannerView setupImageUrls:@[[NSURL URLWithString:@"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=2735633715,2749454924&fm=27&gp=0.jpg"],[NSURL URLWithString:@"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=935292084,2640874667&fm=27&gp=0.jpg"],[NSURL URLWithString:@"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=4277820061,963510529&fm=27&gp=0.jpg"]].mutableCopy];
    [self.view addSubview:bannerView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
