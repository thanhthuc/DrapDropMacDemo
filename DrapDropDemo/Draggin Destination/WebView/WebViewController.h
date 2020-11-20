//
//  WebViewController.h
//  DrapDropDemo
//
//  Created by Thuc Nguyen on 11/16/20.
//  Copyright © 2020 Thuc Nguyen. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CustomWKWebView.h"

NS_ASSUME_NONNULL_BEGIN

@interface WebViewController : NSViewController
@property (nonatomic, strong) CustomWKWebView *wkWebView;
+ (WebViewController *)webBrowserWithConfiguration:(WKWebViewConfiguration *)configuration;
+ (WebViewController *)webBrowser;
- (void)loadURLString:(NSString *)URLString;
- (void)loadURL:(NSURL *)URL;

@end

NS_ASSUME_NONNULL_END
