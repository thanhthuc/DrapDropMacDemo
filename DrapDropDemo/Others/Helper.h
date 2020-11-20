//
//  Helper.h
//  DrapDropDemo
//
//  Created by Thuc Nguyen on 11/12/20.
//  Copyright © 2020 Thuc Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface Helper: NSObject

+ (Helper *)sharedInstance;
/**
Take a snapshot of a current state NSView and return an NSImage

- returns: NSImage representation
*/
- (NSImage *)snapshotWithView:(NSView *)view;

/**
Mutate an NSPoint with a random amount of noise bounded by maximumDelta

- parameter maximumDelta: change range +/-

- returns: mutated point
*/
- (NSPoint)addRandomNoiseWithPoint:(NSPoint)point maximumDelta:(UInt32)maximumDelta;

- (NSImage *)tintImageWithImage:(NSImage *)image color:(NSColor *)color;

- (NSSize)aspectFitSizeForMaxDimensionWithImage:(NSImage *)image maxDimension:(CGFloat)maxDimension;

- (NSColor *)randomColor;

@end
NS_ASSUME_NONNULL_END




