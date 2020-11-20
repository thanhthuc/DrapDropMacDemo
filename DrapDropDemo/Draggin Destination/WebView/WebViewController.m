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
                self.wkWebView = [[CustomWKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
            }
            else {
                self.wkWebView = [[CustomWKWebView alloc] init];
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
    TopBaseView *topBaseView = [[TopBaseView alloc] init];
    [self.view addSubview:topBaseView];
    [self addAutoResizingView:topBaseView toView:self.view];
}

- (void)addAutoResizingView:(NSView *)containerView toView:(NSView *)toView
{
    if (containerView != nil)
    {
        [toView addSubview:containerView];
        
        [containerView setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        [toView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[containerView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(containerView)]];
        [toView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[containerView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(containerView)]];
        
        // Should force update view constraints for update UI correctly.
        // [FM-1270] Show flashing for Flo app when open with Compact mode.
        [toView layoutSubtreeIfNeeded];
        [toView.superview layoutSubtreeIfNeeded];
    }
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
