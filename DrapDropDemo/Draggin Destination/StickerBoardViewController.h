//
//  StickerBoardViewController.h
//  DrapDropDemo
//
//  Created by Thuc Nguyen on 11/12/20.
//  Copyright © 2020 Thuc Nguyen. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DestinationView.h"
#import "WebViewController.h"
#import "TopBaseView.h"
#import "UnderView.h"

NS_ASSUME_NONNULL_BEGIN

@interface StickerBoardViewController : NSViewController<WKNavigationDelegate, WKUIDelegate>

@property (weak) IBOutlet NSTextField *invitationLabel;
@property (weak) IBOutlet NSView *topViewLayerApp;
@property (weak) IBOutlet UnderView *underView;


@end

NS_ASSUME_NONNULL_END
