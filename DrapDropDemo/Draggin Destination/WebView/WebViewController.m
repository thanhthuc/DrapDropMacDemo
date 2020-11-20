//
//  WebViewController.m
//  DrapDropDemo
//
//  Created by Thuc Nguyen on 11/16/20.
//  Copyright © 2020 Thuc Nguyen. All rights reserved.
//

#import "WebViewController.h"
#import "TopBaseView.h"


@interface WebViewController ()

@end


@implementation WebViewController

+ (WebViewController *)webBrowser {
    WKWebViewConfiguration *webViewConfig = [[WKWebViewConfiguration alloc] init];

    //webViewConfig.applicationNameForUserAgent = @"Version/8.0.2 Safari/600.2.5";
    webViewConfig.applicationNameForUserAgent = @"Version/10.1.1 Safari/603.2.4";
    
    WebViewController *webBrowserViewController = [WebViewController webBrowserWithConfiguration:webViewConfig];
    
    return webBrowserViewController;
}

+ (WebViewController *)webBrowserWithConfiguration:(WKWebViewConfiguration *)configuration {
    WebViewController *webBrowserViewController = [[WebViewController alloc] initWithConfiguration:configuration];
    return webBrowserViewController;
}

- (id)init {
    return [self initWithConfiguration:nil];
}

- (id)initWithConfiguration:(WKWebViewConfiguration *)configuration {
    self = [super init];
    if (self) {
        
        if ([WKWebView class]) {
            if (configuration) {
                self.wkWebView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
            }
            else {
                self.wkWebView = [[WKWebView alloc] init];
            }
        }
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    [self updateWebview];
}

- (void)viewWillAppear {
    [super viewWillAppear];
}

- (void)loadURL:(NSURL *)URL {
    if (self.wkWebView) {
        [self.wkWebView loadRequest:[NSURLRequest requestWithURL:URL]];
    }
}

- (void)loadURLString:(NSString *)URLString {
    NSURL *URL = [NSURL URLWithString:URLString];
    if(!URL)
    {
        URL = [NSURL URLWithString:[self stringByPercentEncodingSpecialCharacterWothString:URLString]];
    }
    [self loadURL:URL];
}

- (NSString *)stringByPercentEncodingSpecialCharacterWothString:(NSString *)string{
    NSString * str = [string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]] ;
    str = [[str stringByReplacingOccurrencesOfString:@"\'" withString:@"%27"]stringByReplacingOccurrencesOfString:@"\"" withString:@"%22"];
    return str;
}

- (void)updateWebview {
    if (self.wkWebView) {
        [self.wkWebView setFrame:self.view.bounds];
        [self.wkWebView setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
        [self.wkWebView setNavigationDelegate:self];
        [self.wkWebView setUIDelegate:self];
        [self.wkWebView setAutoresizesSubviews:YES];
        [self.view addSubview:self.wkWebView];
    }
    self.view.wantsLayer = YES;
    self.view.layer.backgroundColor = [[NSColor orangeColor] CGColor];
}



@end
