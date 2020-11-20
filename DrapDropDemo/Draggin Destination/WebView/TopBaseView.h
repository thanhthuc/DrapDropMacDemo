//
//  TopBaseView.h
//  DrapDropDemo
//
//  Created by Thuc Nguyen on 11/16/20.
//  Copyright © 2020 Thuc Nguyen. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TopBaseViewDelegate <NSObject>

-(void)processImageURLs: (NSArray *)urls center:(NSPoint)center;
-(void)processAction:(NSString *)action center:(NSPoint)center;
-(void)processImage:(NSImage *)image center:(NSPoint)center;

@end

@interface TopBaseView : NSView
@property (nonatomic, weak) id<TopBaseViewDelegate> delegate;
@end




NS_ASSUME_NONNULL_END
