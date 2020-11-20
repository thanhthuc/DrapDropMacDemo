//
//  DestinationView.h
//  DrapDropDemo
//
//  Created by Thuc Nguyen on 11/12/20.
//  Copyright © 2020 Thuc Nguyen. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN



@protocol DestinationViewDelegate <NSObject>

-(void)processImageURLs: (NSArray *)urls center:(NSPoint)center;
-(void)processAction:(NSString *)action center:(NSPoint)center;
-(void)processImage:(NSImage *)image center:(NSPoint)center;

@end

@interface DestinationView : NSView

@property (nonatomic, weak) id<DestinationViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
