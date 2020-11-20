//
//  StickerBoardViewController.m
//  DrapDropDemo
//
//  Created by Thuc Nguyen on 11/12/20.
//  Copyright © 2020 Thuc Nguyen. All rights reserved.
//

#import "StickerBoardViewController.h"
#import "Helper.h"
#import "TopViewControllerOnView.h"


@interface StickerBoardViewController ()<DestinationViewDelegate>
@property (nonatomic, strong) WebViewController *webViewVC;
@end

@implementation StickerBoardViewController

static CGFloat maxStickerDimension = 150.0;
static float shadowOpacity =  0.4;
static CGFloat shadowOffset = 4;
static CGFloat imageCompressionFactor = 1.0;
static UInt32 maxRotation = 12;
static CGFloat rotationOffset = 6;
static UInt32 randomNoise = 200;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
//    self.topLayer.delegate = self;
//    [self configureShadow: self.targetLayer];
    _invitationLabel.hidden = NO;
    _invitationLabel.stringValue = @"Let here a view";
    self.topViewLayerApp.wantsLayer = YES;
    self.topViewLayerApp.layer.backgroundColor = [[NSColor greenColor] CGColor];
    self.topViewLayerApp.alphaValue = 1.0;
    [self configTopViewWeb];
    
    [self configUnderView];
    
}


- (void)activeViewController: (NSViewController *)vc toContainer: (NSView *)containerView {
    vc.view.frame = containerView.bounds;
    [vc.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addAutoResizingView:vc.view toView:containerView];
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

- (void)configTopViewWeb {
    
    self.webViewVC = [WebViewController webBrowser];
    [self addChildViewController:self.webViewVC];
    [self activeViewController:self.webViewVC toContainer:self.topViewLayerApp];
    
    self.webViewVC.wkWebView.UIDelegate = self;
    self.webViewVC.wkWebView.navigationDelegate = self;
}

- (void)configureShadow:(NSView *)view {
    view.layer.shadowColor = [[NSColor blackColor] CGColor];
    view.layer.shadowOpacity = shadowOpacity;
    view.layer.shadowOffset = CGSizeMake(shadowOffset, -shadowOffset);
    view.layer.masksToBounds = NO;
}


- (void)configUnderView {
    TopViewControllerOnView *topUnderViewController = [[TopViewControllerOnView alloc] init];
    [self addChildViewController:topUnderViewController];
    [self activeViewController:topUnderViewController toContainer:self.underView];
}

- (IBAction)saveAction:(id)sender {
    
//    NSImage *imageSnapshot = [[Helper sharedInstance] snapshotWithView:self.targetLayer];
//    NSData *tiffData = [imageSnapshot TIFFRepresentation];
//    if (tiffData == nil) {
//        return;
//    }
//    NSBitmapImageRep *bitmapRep = [[NSBitmapImageRep alloc] initWithData:tiffData];
//
//    NSDictionary *props = @{NSImageCompressionFactor: [NSNumber numberWithFloat:imageCompressionFactor]};
//    NSData *bitmapData = [NSBitmapImageRep representationOfImageRepsInArray:@[bitmapRep] usingType:NSBitmapImageFileTypeJPEG properties:props];
//
//    if (bitmapData == nil) { return; }
//
//    NSString *path = @"~/Desktop/StickerDrag.jpg";
//    NSString *resolvedPath = [path stringByExpandingTildeInPath];
//    @try {
//        BOOL result = [bitmapData writeToURL: [[NSURL alloc] initFileURLWithPath:resolvedPath] atomically:NO];
//        if (result) {
//            NSLog(@"Your image has been saved to \(resolvedPath), why not tweet it to us at @raywenderlich #stickerdrag");
//        } else {
//            NSLog(@"Fail to write to file");
//        }
//    } @catch (NSException *exception) {
//        NSLog(@"Fail to write to file with exception: %@", exception.description);
//    } @finally { }
}

- (void)processImage:(NSImage *)image center:(NSPoint)center {
    
//    self.invitationLabel.hidden = YES;
//
    NSSize constrainedSize = [[Helper sharedInstance] aspectFitSizeForMaxDimensionWithImage:image maxDimension:maxStickerDimension];

    NSImageView *subView = [[NSImageView alloc] initWithFrame:NSMakeRect(center.x - constrainedSize.width/2, center.y - constrainedSize.height/2, constrainedSize.width, constrainedSize.height)];

    subView.image = image;
    [self.topViewLayerApp addSubview:subView];

    CGFloat maxrotation = (CGFloat)(arc4random_uniform(maxRotation)) - rotationOffset;
    subView.frameCenterRotation = maxrotation;
    
}

- (void)processImageURLs:(NSArray *)urls center:(NSPoint)center {
    [urls enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSImage *image = [[NSImage alloc] initWithContentsOfURL:obj];
        NSPoint newCenter = center;
        if (idx > 0) {
            newCenter = [[Helper sharedInstance] addRandomNoiseWithPoint:center maximumDelta:randomNoise];
        }
        [self processImage:image center:newCenter];
    }];
}

- (void)processAction:(NSString *)action center:(NSPoint)center {
    
}


- (IBAction)openTab:(id)sender {
//    [self.webViewVC loadURLString:@"https://vnexpress.net"];
    [self.webViewVC loadURLString:@"https://twitter.com"];
    [self.webViewVC.view setNeedsDisplay:YES];
}

#pragma mark - WKNavigationDelegate
-(WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
//    if (!navigationAction.targetFrame.isMainFrame) {
//
//        [webView loadRequest:navigationAction.request];
//    }
//    [self.delegate webBrowser:self createWebViewforNavigationAction:navigationAction];
    return nil;
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    if (webView == self.webViewVC.wkWebView) {
//        if ([self.delegate respondsToSelector:@selector(webBrowser:
//                                        didStartLoadingURL:)]) {
//            [self.delegate webBrowser:self didStartLoadingURL:self.wkWebView.URL];
//        }
    }
    
//    webView.alphaValue = 1;
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    if (webView == self.webViewVC.wkWebView) {
//        if ([self.delegate respondsToSelector:@selector(
//                    webBrowser:didFinishLoadingURL:)]) {
//            [self.delegate webBrowser:self didFinishLoadingURL:self.wkWebView.URL];
//        }
    }
}



- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
      withError:(NSError *)error {
    if (webView == self.webViewVC.wkWebView) {
//        if ([self.delegate respondsToSelector:@selector(
//                webBrowser:didFailToLoadURL:error:)]) {
//            [self.delegate webBrowser:self didFailToLoadURL:self.wkWebView.URL error:error];
//        }
    }
    
    webView.alphaValue = 0;
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation
      withError:(NSError *)error {
    if (webView == self.webViewVC.wkWebView) {
//        if ([self.delegate respondsToSelector:@selector(
//                webBrowser:didFailToLoadURL:error:)]) {
//            [self.delegate webBrowser:self didFailToLoadURL:self.wkWebView.URL error:error];
//        }
    }
}

@end
