# JDBannerView

[![CI Status](https://img.shields.io/travis/13432414304@163.com/JDBannerView.svg?style=flat)](https://travis-ci.org/13432414304@163.com/JDBannerView)
[![Version](https://img.shields.io/cocoapods/v/JDBannerView.svg?style=flat)](https://cocoapods.org/pods/JDBannerView)
[![License](https://img.shields.io/cocoapods/l/JDBannerView.svg?style=flat)](https://cocoapods.org/pods/JDBannerView)
[![Platform](https://img.shields.io/cocoapods/p/JDBannerView.svg?style=flat)](https://cocoapods.org/pods/JDBannerView)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

JDBannerView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'JDBannerView'
```

## 使用
```
#import "JDBannerView.h"

JDBannerView *bannerView = [JDBannerView initBannerViewWithFrame:frame];
[bannerView setupImageUrls:@[imageUrl1,imageurl2,...].mutableCopy];
[self.view addSubview:bannerView];

```

## Author

Jedediah, 13432414304@163.com

## License

JDBannerView is available under the MIT license. See the LICENSE file for more info.
